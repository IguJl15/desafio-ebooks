import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/home_cubit/home_cubit.dart';
import 'cubits/home_cubit/home_state.dart';
import 'widgets/layout/grid_with_title.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
        if (state.isLoading) return const Center(child: CircularProgressIndicator());

        return HomeEbooksList(
          title: const Text("Favoritos"),
          ebooks: state.bookmarkedEbooks,
          bookmarkedEbooks: state.bookmarkedEbooks,
        );
      },
    );
  }
}
