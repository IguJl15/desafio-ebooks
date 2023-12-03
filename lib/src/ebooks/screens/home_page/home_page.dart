import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../shared/shared_preference.dart';
import '../../data/bookmarks_repository.dart';
import '../../data/ebook_downloads_controller.dart';
import '../../data/ebook_repository.dart';
import 'all_ebooks_page.dart';
import 'bookmark_page.dart';
import 'cubits/home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        ebooksRepository: EbookRepository(
          client: Client(),
          downloadManager: EbookDownloadsController.instance,
        ),
        bookmarkRepository: BookmarksRepository(sharedPrefs: AppSharedPreferenceSingleton.instance),
      )..pageRefreshed(),
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text("Escribo"),
                  snap: true,
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(icon: Icon(Icons.book), text: "eBooks"),
                      Tab(
                        icon: Icon(Icons.bookmark),
                        text: "Favoritos",
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              AllEbooksPage(key: PageStorageKey("main_ebooks_page")),
              BookmarkPage(key: PageStorageKey("bookmark_ebooks_page")),
            ],
          ),
        ),
      ),
    );
  }
}
