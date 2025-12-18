import 'package:flutter/material.dart';
import '../data/model/article_model.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Article> _bookmarks = [];

  List<Article> get bookmarks => _bookmarks;
  void toggleBookmark(Article article) {
    if (_bookmarks.contains(article)) {
      _bookmarks.remove(article);
    } else {
      _bookmarks.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarks.contains(article);
  }
}
