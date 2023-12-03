import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/extensions.dart';
import '../../../../models/ebook.dart';
import '../../cubits/ebook_cubit/ebook_cubit.dart';
import '../../cubits/ebook_cubit/ebook_state.dart';
import 'book_cover.dart';
import 'bookmark_button.dart';
import 'download_status.dart';

class EbookCard extends StatelessWidget {
  const EbookCard({
    super.key,
    required this.ebook,
    required this.bookmarked,
    required this.onBookmarkButtonPressed,
  });

  final Ebook ebook;

  final bool bookmarked;
  final Function(Ebook) onBookmarkButtonPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(8));
    return BlocProvider(
      create: (_) => EbookCubit(ebook: ebook),
      child: Card(
        margin: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.themeData.colorScheme.outlineVariant),
            borderRadius: borderRadius,
            image: DecorationImage(
              image: CachedNetworkImageProvider(ebook.coverImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              const DownloadStatus(),
              Cover(ebook: ebook),
              BookmarkButton(active: bookmarked, onTap: () => onBookmarkButtonPressed(ebook)),
            ],
          ),
        ),
      ),
    );
  }
}

class Cover extends StatelessWidget {
  const Cover({super.key, required this.ebook});

  final Ebook ebook;

  void coverPressed(BuildContext context, EbookState state) {
    final cubit = context.read<EbookCubit>();

    state.when(
      (isDownloaded) {
        if (!isDownloaded) {
          cubit.ebookCoverPressed();
        } else {
          context.push("/read/${cubit.ebook.id}", extra: cubit.ebook);
        }
      },
      downloading: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EbookCubit, EbookState>(
      builder: (context, state) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => coverPressed(context, state),
          child: BookCover(ebook: ebook),
        ),
      ),
    );
  }
}
