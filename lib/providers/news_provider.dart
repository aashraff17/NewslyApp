import 'package:flutter/material.dart';
import '../data/services/news_service.dart';
import '../data/model/article_model.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;

  String _selectedCategory = 'general';
  String _selectedCountry = 'us';

  // ✅ GETTERS (USED BY UI)
  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get selectedCountry => _selectedCountry;

  /// Fetch news
  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchNews(
        category: _selectedCategory,
        country: _selectedCountry,
      );
    } catch (e) {
      debugPrint('News error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Change category
  Future<void> changeCategory(String category) async {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    await fetchNews();
  }

  /// Change country
  Future<void> changeCountry(String country) async {
    if (_selectedCountry == country) return;
    _selectedCountry = country;
    await fetchNews();
  }

  /// Used by CategoryArticlesPage
  Future<void> fetchByCategory(String category) async {
    _selectedCategory = category;
    await fetchNews();
  }
}
