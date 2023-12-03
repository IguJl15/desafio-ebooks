import 'cubits/home_cubit/home_state.dart';

import '../../data/bookmarks_repository.dart';
import '../../data/ebook_repository.dart';
import 'cubits/home_cubit/home_cubit.dart';
import '../../../shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../shared/extensions.dart';
import 'widgets/ebook_card/ebook_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        ebooksRepository: EbookRepository(client: Client()),
        bookmarkRepository: BookmarksRepository(sharedPrefs: AppSharedPreferenceSingleton.instance),
      )..pageRefreshed(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escribo'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.error != null) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
            if (state.isLoading) return const Center(child: CircularProgressIndicator());

            return LayoutBuilder(
              builder: (context, constraints) {
                final columnCount = switch (constraints.maxWidth) {
                  < 512 => 2,
                  < 768 => 3,
                  _ => 4,
                };

                return ListView(
                  padding: EdgeInsetsExtension.centerOnBoxConstraints(constraints: constraints, maxWidth: 1024),
                  children: [
                    Text("eBooks", style: context.themeData.textTheme.headlineSmall),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnCount,
                        childAspectRatio: 3 / 4,
                      ),
                      children: List.generate(
                        state.ebooks.length,
                        (index) => EbookCard(
                          ebook: state.ebooks[index],
                          bookmarked: state.bookmarkedEbooks.contains(state.ebooks[index]),
                          onBookmarkButtonPressed: context.read<HomeCubit>().bookmarkEbook,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
