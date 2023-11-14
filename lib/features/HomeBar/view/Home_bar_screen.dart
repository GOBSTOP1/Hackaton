import 'package:flutter/material.dart';
import 'package:hackaton2/features/Account/view/account_screen.dart';
import 'package:hackaton2/features/Menu/Menu.dart';

import '../widgets/Home_bar_widget.dart';





class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}
   final List<Widget> pages = [ 
      Menu(),
      Account(),
     
      ];
class _HomeBarState extends State<HomeBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
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
      body:pages[currentPageIndex],
      
    );
  }
}

