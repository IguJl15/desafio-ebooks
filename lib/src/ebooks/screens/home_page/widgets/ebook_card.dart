// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_ebook/src/ebooks/models/ebook.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/widgets/book_cover.dart';
import 'package:desafio_ebook/src/ebooks/screens/home_page/widgets/favorite_button.dart';
import 'package:flutter/material.dart';

import '../../../../shared/extensions.dart';

class EbookCard extends StatefulWidget {
  const EbookCard({required this.ebook, super.key});

  final Ebook ebook;

  @override
  State<EbookCard> createState() => _EbookCardState();
}

class _EbookCardState extends State<EbookCard> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.ebook.coverImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: BookCover(ebook: widget.ebook),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: FavoriteButton(onTap: () => setState(() => isFavorite = !isFavorite), active: isFavorite),
            ),
          ],
        ),
      ),
    );
  }
}
