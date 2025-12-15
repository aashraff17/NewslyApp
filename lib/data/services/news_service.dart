import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class NewsService {
  static const String _apiKey = '35d9ac1839e62a7e18d9c31702ac70d3';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchNews({
    required String category,
    required String country,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/top-headlines'
          '?country=$country'
          '&category=$category'
          '&apiKey=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load news');
    }

    final data = jsonDecode(response.body);

    final List articles = data['articles'] ?? [];

    return articles
        .where((e) => e['urlToImage'] != null)
        .map((e) => Article.fromJson(e))
        .toList();
  }
}
