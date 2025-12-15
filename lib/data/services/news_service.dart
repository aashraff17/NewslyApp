import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class NewsService {
  static const String _baseUrl = 'https://gnews.io/api/v4';
  static const String _apiKey = '68245bb7f9d4227f6e90deabf2afa8d6';

  Future<List<Article>> fetchTopHeadlines({
    String category = 'general',
    String country = 'us',
  }) async {
    final url = Uri.parse(
      '$_baseUrl/top-headlines'
          '?category=$category'
          '&country=$country'
          '&lang=en'
          '&max=10'
          '&apikey=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
