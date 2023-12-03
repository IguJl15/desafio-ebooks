import 'dart:developer';

import 'package:bloc/bloc.dart' show Cubit;
import 'home_state.dart';
import '../../../../data/bookmarks_repository.dart';
import '../../../../data/ebook_repository.dart';
import '../../../../models/ebook.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.ebooksRepository, required this.bookmarkRepository}) : super(const HomeState());

  final EbookRepository ebooksRepository;
  final BookmarksRepository bookmarkRepository;

  void pageRefreshed() async {
    final previousState = state;

    emit(state.toLoading());

    try {
      final ebooks = await ebooksRepository.getAllAvailableEbooks();

      final bookmarkedBooksIds = bookmarkRepository.getAllBookmarkedBookIds();

      emit(
        state.withBooks(
          ebooks: ebooks,
          bookmarkedEbooks: ebooks.where((element) => bookmarkedBooksIds.contains(element.id)).toList(),
        ),
      );
    } on Exception catch (e) {
      log('', error: e);
      emit(previousState.withError("Ocorreu um erro durante a procura por eBooks. Por favor tente novamente"));
    }
  }

  void bookmarkEbook(Ebook ebook) {
    final newFavoriteState = bookmarkRepository.toggleEbookFavorite(ebook);

    emit(
      state.copyWith(
        bookmarkedEbooks: newFavoriteState == true //
            ? (state.bookmarkedEbooks..add(ebook))
            : (state.bookmarkedEbooks..remove(ebook)),
      ),
    );
  }
}

extension _StateOperations on HomeState {
  HomeState withBooks({
    required List<Ebook> ebooks,
    required List<Ebook> bookmarkedEbooks,
  }) =>
      copyWith(
        ebooks: ebooks,
        bookmarkedEbooks: bookmarkedEbooks,
        isLoading: false,
      );
  HomeState toLoading() => copyWith(isLoading: true);
  HomeState withError(String error) => copyWith(error: error);
}
