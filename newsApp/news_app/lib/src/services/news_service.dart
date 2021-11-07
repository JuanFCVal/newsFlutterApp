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
  List<Article> categoryNews = [];
  String selectedCategory = "business";
  bool loading = true;
  List<Category> categoies = [
    Category(FontAwesomeIcons.building, "business"),
    Category(FontAwesomeIcons.tv, "entertainment"),
    Category(FontAwesomeIcons.addressCard, "general"),
    Category(FontAwesomeIcons.headSideVirus, "health"),
    Category(FontAwesomeIcons.vials, "science"),
    Category(FontAwesomeIcons.volleyballBall, "sports"),
    Category(FontAwesomeIcons.memory, "technology")
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categoies.forEach((item) {
      categoryArticles[item.name] = [];
    });
    getHeadlinesByCategory(selectedCategory);
  }

  String get SelectedCategory {
    return selectedCategory;
  }

  set SelectedCategory(String value) {
    this.loading = true;
    selectedCategory = value;

    getHeadlinesByCategory(value);
    notifyListeners();
  }

  bool get isLoading => this.loading;

  List<Article> get CategoryArticles =>
      categoryArticles[selectedCategory] ?? [];

  getTopHeadlines() async {
    final url = Uri.parse('$_URL/top-headlines?country=us&apiKey=$_apiKey');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles!);
    notifyListeners();
  }

  getHeadlinesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      this.loading = false;
      return categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL/top-headlines?country=us&apiKey=$_apiKey&category=$category');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles!);
    print(categoryArticles[category]);
    this.loading = false;
    notifyListeners();
  }
}
