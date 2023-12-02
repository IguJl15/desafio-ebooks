import 'dart:developer';

import 'package:bloc/bloc.dart' show Cubit;
import 'package:desafio_ebook/src/ebooks/data/ebook_repository.dart';
import 'package:desafio_ebook/src/ebooks/models/ebook.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.ebooksRepository}) : super(HomeState.loading());

  final EbookRepository ebooksRepository;

  void pageRefreshed() async {
    try {
      final ebooks = await ebooksRepository.getAllAvailableEbooks();

      emit(HomeState.success(ebooks: ebooks));
      // final newState =
    } on Exception catch (e) {
      log('', error: e);
      emit(HomeState.error(error: "Ocorreu um erro durante a procura por eBooks. Por favor tente novamente"));
    }
  }

  void favoriteEbook(Ebook ebook){

  }
  
}
