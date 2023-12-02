import 'package:desafio_ebook/src/ebooks/data/ebook_repository.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/cubit/home_cubit.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../shared/extensions.dart';
import 'widgets/ebook_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(ebooksRepository: EbookRepository(client: Client()))..pageRefreshed(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escribo'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.map(
                error: (_) => const Text("Infelizmente ocorreu um erro..."),
                loading: (_) => const Center(child: CircularProgressIndicator()),
                success: (state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final columnCount = switch (constraints.maxWidth) {
                        < 512 => 2,
                        < 768 => 3,
                        _ => 4,
                      };
                      return ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: (constraints.maxWidth - 1024).clamp(0, double.maxFinite) / 2),
                        children: [
                          Text("eBooks", style: context.themeData.textTheme.headlineSmall),
                          GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columnCount,
                              childAspectRatio: 3 / 4,
                            ),
                            children:
                                List.generate(state.ebooks.length, (index) => EbookCard(ebook: state.ebooks[index])),
                          ),
                        ],
                      );
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
