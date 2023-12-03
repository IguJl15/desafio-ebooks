import 'dart:convert';
import 'dart:io';

import 'package:desafio_ebook/src/ebooks/data/ebook_downloads_controller.dart';
import 'package:http/http.dart';

import '../../shared/constants.dart';
import '../models/ebook.dart';

class EbookRepository {
  final Client client;
  final EbookDownloadsController downloadManager;

  EbookRepository({
    required this.client,
    required this.downloadManager,
  });

  Future<List<Ebook>> getAllAvailableEbooks() async {
    try {
      final response = await client.get(Uri.parse("$host/books.json"));

      if (response.statusCode >= 400) {}
      final data = jsonDecode(response.body);
      return (data as List).map((json) => Ebook.fromJson(json)).toSet().toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Ebook> getEbook(int id) async {
    final list = await getAllAvailableEbooks();

    final ebook = list.where((element) => element.id == id).firstOrNull;

    if (ebook == null) throw Exception("Ebook não encontrado");

    return ebook;
  }

  File getEbookAsset(Ebook ebook) {
    if (downloadManager.isEbookDownloaded(ebook)) {
      return File(downloadManager.downloadedEbooks[ebook.id]!);
    } else {
      throw UnimplementedError();
    }
  }
}
