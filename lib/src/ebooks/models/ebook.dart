import 'package:freezed_annotation/freezed_annotation.dart';

part 'ebook.freezed.dart';
part 'ebook.g.dart';

@freezed
abstract class Ebook with _$Ebook {
  const factory Ebook({
    required int id,
    required String title,
    required String author,
    @JsonKey(name: 'cover_url') //
    required String coverImageUrl,
    @JsonKey(name: 'download_url') //
    required String downloadUrl,
  }) = _Ebook;
  factory Ebook.fromJson(Map<String, dynamic> json) => _$EbookFromJson(json);
}
