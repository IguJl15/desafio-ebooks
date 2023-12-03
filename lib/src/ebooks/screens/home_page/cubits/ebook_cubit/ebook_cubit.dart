import 'dart:developer';

import '../../../../data/ebook_downloads_controller.dart';
import '../../../../models/ebook.dart';
import 'ebook_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EbookCubit extends Cubit<EbookState> {
  EbookCubit({required Ebook ebook})
      : _ebook = ebook,
        super(
          EbookState(isDownloaded: _downloadManager.isEbookDownloaded(ebook)),
        );

  final Ebook _ebook;
  static final _downloadManager = EbookDownloadsController.instance;

  void ebookCoverPressed() {
    if (state is Downloading || _downloadManager.isEbookDownloaded(_ebook)) {
      return;
    }
    final stream = _downloadManager.startDownload(_ebook);

    stream
        .map((event) => EbookState.downloading(
              progress: event.bytesDownloaded / event.totalSize,
            ))
        .listen((event) {
      log(event.toString());
      emit(event);
    }, onDone: () {
      emit(const EbookState(isDownloaded: true));
    });
  }
}
