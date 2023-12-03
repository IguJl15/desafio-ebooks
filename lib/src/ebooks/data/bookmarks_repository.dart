import 'package:shared_preferences/shared_preferences.dart';

import '../models/ebook.dart';

class BookmarksRepository {
  BookmarksRepository({required this.sharedPrefs});
  static const bookmarkStorageKey = "bookmarks";

  final SharedPreferences sharedPrefs;

  // Returns the current bookmark state stored
  bool toggleEbookFavorite(Ebook ebook) {
    final favorites = getAllBookmarkedBookIds();

    final bool state;
    if (favorites.contains(ebook.id)) {
      favorites.remove(ebook.id);
      state = false;
    } else {
      favorites.add(ebook.id);
      state = true;
    }

    sharedPrefs.setStringList(
      bookmarkStorageKey,
      favorites.map((e) => e.toString()).toList(),
    );

    return state;
  }

  List<int> getAllBookmarkedBookIds() {
    var favoritesString = sharedPrefs.getStringList(bookmarkStorageKey);

    if (favoritesString == null) return [];

    return favoritesString.map((e) => int.parse(e)).toList();
  }
}
