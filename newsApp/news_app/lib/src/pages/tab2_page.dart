import 'package:flutter/material.dart';
import 'package:news_app/src/models/newsModels/category.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(
      context,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 90, child: categoryList()),
            (newsService.isLoading)
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListaNoticias(
                      newsService.CategoryArticles,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class categoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categoies;

    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final name = categories[index].name;
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  categoryButton(categories[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${name[0].toUpperCase()}${name.substring(1)}',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class categoryButton extends StatelessWidget {
  final Category category;

  categoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        newsService.SelectedCategory = category.name;
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (newsService.SelectedCategory == this.category.name)
                ? Colors.lightBlue
                : Colors.white,
          ),
          child: Icon(category.icon, color: Colors.black)),
    );
  }
}
