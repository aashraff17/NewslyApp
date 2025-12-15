import 'package:flutter/material.dart';
import '../data/model/article_model.dart';
import '../data/services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _selectedCategory = 'general';
  String _selectedCountry = 'us';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get selectedCountry => _selectedCountry;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines(
        category: _selectedCategory,
        country: _selectedCountry,
      );
    } catch (e) {
      debugPrint('Error fetching news: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    fetchNews();
  }

  void changeCountry(String country) {
    _selectedCountry = country;
    fetchNews();
  }
}
