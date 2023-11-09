import 'package:flutter/material.dart';


import 'screens.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).appBarTheme.iconTheme?.color,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Hackaton'),
        actions: const [],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Меню',
          ),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          NavigationDestination(
            icon: Icon(Icons.verified_user),
            label: 'Профиль',
          )
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
      ][currentPageIndex],
      drawer: DrawerBloc(),
    );
  }
}

