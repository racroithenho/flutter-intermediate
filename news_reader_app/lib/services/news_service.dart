import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  static const String _apiKey = 'YOUR_API_KEY_HERE';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  static const String _country = 'us';

  Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse('$_baseUrl?country=$_country&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
