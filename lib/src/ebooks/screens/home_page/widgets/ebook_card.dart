// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../shared/extensions.dart';

class EbookCard extends StatefulWidget {
  const EbookCard({super.key});

  @override
  State<EbookCard> createState() => _EbookCardState();
}

class _EbookCardState extends State<EbookCard> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider("https://placehold.co/450x600/light-grey/grey/png?text=Olá+Mundo"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.black54,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Título do livro", style: context.themeData.textTheme.titleLarge),
                    Text(
                      "Autor pode ter um nome grande",
                      maxLines: 2,
                      style: context.themeData.textTheme.bodyMedium! //
                          .copyWith(color: context.themeData.colorScheme.onSurfaceVariant),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: FilledButton(
                    child: Container(),
                    onPressed: () => setState(() {
                      isFavorite = !isFavorite;
                    }),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(30, 60),
                      maximumSize: const Size(30, 60),
                      fixedSize: const Size(30, 60),
                      backgroundColor: isFavorite ? Colors.red : Colors.grey[50],
                      surfaceTintColor: Colors.red[100],
                      elevation: isFavorite ? 1 : 2,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
