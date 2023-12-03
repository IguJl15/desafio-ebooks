import 'package:flutter/material.dart';

import '../../../../../shared/extensions.dart';
import '../../../../models/ebook.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.ebook,
  });

  final Ebook ebook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.black87,
          Colors.transparent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            ebook.title,
            style: context.themeData.textTheme.titleLarge! //
                .copyWith(shadows: kElevationToShadow[1], color: Colors.white),
          ),
          Text(
            ebook.author,
            maxLines: 2,
            style: context.themeData.textTheme.bodyMedium! //
                .copyWith(color: Colors.grey[100]),
          )
        ],
      ),
    );
  }
}
