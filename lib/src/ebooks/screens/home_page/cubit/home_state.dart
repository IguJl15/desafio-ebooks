import 'package:desafio_ebook/src/ebooks/models/ebook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState.loading() = Loading;
  factory HomeState.error({required String error}) = Error;
  factory HomeState.success({required List<Ebook> ebooks}) = Success;
}
