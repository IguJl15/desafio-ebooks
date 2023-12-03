import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/ebook.dart';

part 'home_state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false, equal: false)
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Ebook> ebooks,
    @Default([]) List<Ebook> bookmarkedEbooks,
    @Default([]) List<Map<int, double>> downloads,
    String? error,
    @Default(false) bool isLoading,
  }) = _HomeState;
}
