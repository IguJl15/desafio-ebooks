import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/ebook.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import '../ebook_card/ebook_card.dart';

class EbooksSliverGrid extends StatelessWidget {
  const EbooksSliverGrid({
    super.key,
    required this.ebooks,
    required this.bookmarkedEbooks,
    required this.columnsCount,
    this.spacing = 4,
  });

  final List<Ebook> ebooks;
  final List<Ebook> bookmarkedEbooks;
  final int columnsCount;

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: ebooks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnsCount,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (BuildContext context, int index) {
        return EbookCard(
          ebook: ebooks[index],
          bookmarked: bookmarkedEbooks.contains(ebooks[index]),
          onBookmarkButtonPressed: context.read<HomeCubit>().bookmarkEbook,
        );
      },
    );
  }
}
