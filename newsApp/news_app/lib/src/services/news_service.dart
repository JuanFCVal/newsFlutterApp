// apikey 0e17d79662db4613b42913697f7db4f2
import 'package:flutter/material.dart';
import 'package:news_app/src/models/newsModels/news.dart';
import 'package:http/http.dart' as http;

final _URL = "https://newsapi.org/v2";
final _apiKey = "0e17d79662db4613b42913697f7db4f2";

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    final url = Uri.parse('$_URL/top-headlines?country=us&apiKey=$_apiKey');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles!);
    notifyListeners();
  }
}
