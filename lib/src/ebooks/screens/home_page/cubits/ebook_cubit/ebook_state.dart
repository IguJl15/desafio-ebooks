import 'package:freezed_annotation/freezed_annotation.dart';

part 'ebook_state.freezed.dart';

@freezed
abstract class EbookState with _$EbookState {
  const factory EbookState({required bool isDownloaded}) = _EbookState;

  const factory EbookState.downloading({required double progress}) = Downloading;
}
