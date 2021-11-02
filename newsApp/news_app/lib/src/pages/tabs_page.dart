import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}

class bottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navegacionModel.indice,
      onTap: (int index) {
        navegacionModel.indice = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: ('Para ti'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: ('Encabezados'),
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      children: [
        Tab1Page(),
        Container(
          color: Colors.blue,
          child: Column(
            children: <Widget>[],
          ),
        ),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _indice = 0;
  PageController _pageController = new PageController();
  int get indice => this._indice;

  set indice(int valor) {
    _indice = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
