import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: TabsPage());
  }
}
