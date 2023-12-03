import 'package:flutter/material.dart';

import '../../../../../shared/extensions.dart';
import '../../../../models/ebook.dart';
import 'ebooks_grid.dart';

class HomeEbooksList extends StatelessWidget {
  const HomeEbooksList({
    required this.title,
    required this.ebooks,
    required this.bookmarkedEbooks,
    this.padding = const EdgeInsets.all(6),
    this.contentMaxWidth = 1024,
    super.key,
  });

  final Widget title;
  final EdgeInsets padding;
  final List<Ebook> ebooks;
  final List<Ebook> bookmarkedEbooks;
  final double contentMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final int columnCount;
        final double spacing;

        switch (constraints.maxWidth) {
          case < 260:
            columnCount = 1;
            spacing = 4;
          case < 512:
            columnCount = 2;
            spacing = 4;
          case < 768:
            columnCount = 3;
            spacing = 8;
          default:
            columnCount = 4;
            spacing = 12;
        }

        final centerPadding =
            EdgeInsetsExtension.centerOnBoxConstraints(constraints: constraints, maxWidth: contentMaxWidth);

        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverPadding(
              padding: centerPadding + padding.copyWith(bottom: 0),
              sliver: SliverToBoxAdapter(
                child: DefaultTextStyle(
                  style: context.themeData.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                  child: title,
                ),
              ),
            ),
            SliverPadding(
              padding: centerPadding + padding,
              sliver: EbooksSliverGrid(
                ebooks: ebooks,
                bookmarkedEbooks: bookmarkedEbooks,
                columnsCount: columnCount,
                spacing: spacing,
              ),
            )
          ],
        );
      },
    );
  }
}
