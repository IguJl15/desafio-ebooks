// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_ebook/src/ebooks/models/ebook.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/cubits/ebook_cubit/ebook_cubit.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/cubits/ebook_cubit/ebook_state.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/widgets/ebook_card/book_cover.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/widgets/ebook_card/bookmark_button.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/widgets/ebook_card/download_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (_) => EbookCubit(ebook: ebook),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Container(
          decoration: BoxDecoration(
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
          log("ta baixado");
        }
      },
      downloading: (_) {
        log("Diz que ta baixando");
      },
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
