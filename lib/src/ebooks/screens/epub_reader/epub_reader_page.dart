import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../../shared/extensions.dart';
import '../../data/ebook_downloads_controller.dart';
import '../../data/ebook_repository.dart';
import '../../models/ebook.dart';

class EpubReader extends StatefulWidget {
  final int ebookId;
  final Ebook? ebook;

  const EpubReader({
    super.key,
    required this.ebook,
    required this.ebookId,
  });

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  final loading = true;
  final repository = EbookRepository(client: Client(), downloadManager: EbookDownloadsController.instance);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.ebook != null) {
        openEpubReader(widget.ebook!);
      } else {
        repository.getEbook(widget.ebookId).then(openEpubReader);
      }
    });
  }

  openEpubReader(Ebook ebook) {
    final file = repository.getEbookAsset(ebook);

    VocsyEpub.setConfig(
      themeColor: context.themeData.primaryColor,
      allowSharing: true,
      enableTts: true,
      nightMode: context.themeData.brightness == Brightness.dark,
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    );
    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
      // Pelo que parece, essa stream só recebe dados ao sair do leitor
      log('LOCATOR: $locator');
    });

    VocsyEpub.open(file.path);

    context.pop(); // Sair da pagina para que, ao sair do leitor, o usuário se encontre na tela inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: !Platform.isAndroid && !Platform.isIOS
            ? const Text(
                "Desculpe, parece que você esta usando um "
                "dispositivo que não é compatível com o leitor de eBooks",
              )
            : const Text("Estamos preparando seu leitor"),
      ),
    );
  }
}
