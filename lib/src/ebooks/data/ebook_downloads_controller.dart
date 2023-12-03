import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../models/ebook.dart';

class EbookDownloadsController {
  static EbookDownloadsController? _instance;
  // Avoid self instance
  EbookDownloadsController._();
  static EbookDownloadsController get instance => _instance ??= EbookDownloadsController._();
  static Future<void> initialize() async {
    await instance._checkExistingFiles();
  }

  final client = Client();
  // Maps file path to its ebook
  final Map<int, String> _downloadedEbooks = {};
  Future<Directory> get _downloadDestinationPath => getApplicationSupportDirectory();

  bool isEbookDownloaded(Ebook ebook) {
    return _downloadedEbooks.containsKey(ebook.id);
  }

  Stream<DownloadProgress> startDownload(Ebook ebook) async* {
    if (_downloadedEbooks.containsKey(ebook.id)) {
      throw Exception("O livro ${ebook.title} (${ebook.id}) livro ja foi baixado");
    }

    log("Iniciando download do livro");
    final response = await client.send(Request("GET", Uri.parse(ebook.downloadUrl)));
    final broadcastStream = response.stream.asBroadcastStream(
      onCancel: (controller) {
        controller.pause();
      },
    );

    final totalSize = response.contentLength ?? 0;
    int bytesDownloaded = 0;
    final bytes = <int>[];

    final progressStream = broadcastStream.map(
      (chunk) {
        bytes.addAll(chunk);
        return DownloadProgress(
          ebook: ebook,
          totalSize: totalSize,
          bytesDownloaded: bytesDownloaded += chunk.length,
        );
      },
    );

    final sub = broadcastStream.listen(
      (event) {},
    );

    sub.onDone(() async {
      sub.cancel();

      final completeResponse = Response.bytes(bytes, response.statusCode, headers: response.headers);

      final savedFile = await _saveFile(ebook, completeResponse);

      _downloadedEbooks.putIfAbsent(ebook.id, () => savedFile.path);
    });

    yield* progressStream;
  }

  Future<File> _saveFile(Ebook ebook, Response response) async {
    final baseDirectory = await _downloadDestinationPath;
    final downloadDirectory = Directory("${baseDirectory.path}/${ebook.id}");

    log("Salvando arquivo no seguinte local: ${downloadDirectory.path}");
    if (!downloadDirectory.existsSync()) downloadDirectory.createSync(recursive: true);

    final fileName = getFileNameFromResponse(response);
    final file = File("${downloadDirectory.path}/$fileName");
    if (!file.existsSync()) file.createSync();

    return await file.writeAsBytes(response.bodyBytes);
  }

  String getFileNameFromResponse(Response response) {
    if (response.headers.containsKey("Content-Disposition")) {
      final contentDisposition = response.headers["Content-Disposition"]!.split("; ");
      for (final part in contentDisposition) {
        if (part.startsWith("filename=")) {
          return part.split("=")[1].trim();
        }
      }
    }

    return "download.epub"; // Assuming the ebook is an EPUB file
  }

  Future<void> _checkExistingFiles() async {
    final baseDirectory = await _downloadDestinationPath;

    if (!baseDirectory.existsSync()) {
      return;
    }

    final entities = baseDirectory.listSync();

    final ebooksIdsFolders = entities //
        .where((element) => int.tryParse(element.name) != null)
        .toList();

    for (var folder in ebooksIdsFolders) {
      if (folder.statSync().type != FileSystemEntityType.directory) {
        continue;
      }

      final file = Directory(folder.path).listSync().map((e) => File(e.path)).first;

      if (file.lengthSync() > 0) {
        _downloadedEbooks.putIfAbsent(int.parse(folder.name), () => file.path);
      }
    }

    log('Downloads inicializados');
  }
}

class DownloadProgress {
  final Ebook ebook;
  final int totalSize;
  final int bytesDownloaded;

  DownloadProgress({
    required this.ebook,
    required this.totalSize,
    required this.bytesDownloaded,
  });
}

extension FileName on FileSystemEntity {
  String get name => path.split("/").lastOrNull ?? '';
}
