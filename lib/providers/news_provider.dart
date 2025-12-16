import 'package:flutter/material.dart';
import '../data/model/article_model.dart';
import '../data/mock/mock_news.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;

  String _selectedCategory = 'sports';
  String _selectedCountry = 'us';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get selectedCountry => _selectedCountry;
  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    // load current category mock data
    _articles = mockNews[_selectedCategory] ?? [];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300)); // simulate loading

    _selectedCategory = category;
    _articles = mockNews[category] ?? [];

    _isLoading = false;
    notifyListeners();
  }

  void changeCategory(String category) {
    fetchByCategory(category);
  }

  void changeCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
