import 'package:flutter/material.dart';

import '../../../shared/extensions.dart';
import 'widgets/ebook_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escribo'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.menu_book_outlined), child: Text("eBooks")),
            Tab(icon: Icon(Icons.bookmark), child: Text("Favoritos")),
          ]),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final columnCount = switch (constraints.maxWidth) {
            < 512 => 2,
            < 768 => 3,
            _ => 4,
          };
          return Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: (constraints.maxWidth - 1024).clamp(0, double.maxFinite) / 2),
              children: [
                Text("eBooks", style: context.themeData.textTheme.headlineSmall),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnCount,
                    childAspectRatio: 3 / 4,
                  ),
                  children: const [
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                    EbookCard(),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
