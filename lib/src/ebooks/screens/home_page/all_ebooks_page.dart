import 'cubits/home_cubit/home_cubit.dart';
import 'cubits/home_cubit/home_state.dart';
import 'widgets/layout/grid_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllEbooksPage extends StatelessWidget {
  const AllEbooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
        if (state.isLoading) return const Center(child: CircularProgressIndicator());

        return HomeEbooksList(
          title: const Text("eBooks Disponíveis"),
          ebooks: state.ebooks,
          bookmarkedEbooks: state.bookmarkedEbooks,
        );
      },
    );
  }
}
