// apikey 0e17d79662db4613b42913697f7db4f2
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/newsModels/category.dart';
import 'package:news_app/src/models/newsModels/news.dart';
import 'package:http/http.dart' as http;

final _URL = "https://newsapi.org/v2";
final _apiKey = "0e17d79662db4613b42913697f7db4f2";

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categoies = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "technology")
  ];
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
