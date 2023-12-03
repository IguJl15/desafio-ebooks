import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/ebook_downloads_controller.dart';
import '../../../../models/ebook.dart';
import 'ebook_state.dart';

class EbookCubit extends Cubit<EbookState> {
  EbookCubit({required Ebook ebook})
      : _ebook = ebook,
        super(
          EbookState(isDownloaded: _downloadManager.isEbookDownloaded(ebook)),
        );

  Ebook get ebook => _ebook;
  final Ebook _ebook;
  static final _downloadManager = EbookDownloadsController.instance;

  void ebookCoverPressed() {
    if (state is Downloading || _downloadManager.isEbookDownloaded(_ebook)) {
      return;
    }
    final stream = _downloadManager.startDownload(_ebook);

    final statesStream = stream.map((event) {
      final percentage = event.bytesDownloaded / event.totalSize;

      return EbookState.downloading(progress: percentage);
    });

    statesStream.listen(
      (event) {
        emit(event);
      },
      onDone: () {
        emit(const EbookState(isDownloaded: true));
      },
    );
  }
}
