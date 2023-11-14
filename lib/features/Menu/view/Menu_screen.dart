import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';

import '../../../repositories/Menu/models/menu_dish.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Dish>? _dishList;
  

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  Future<void> _loadMenu() async {
    // final menuRepository = MenuRepository();
     _dishList = await GetIt.I<AbstractMenuRepository>().loadMenu();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            title: Text(
              'CorpFoooooood',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child:
                _buildHorizontalCardList(), // Ваш список горизонтальных карточек
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildMenuItemCard(_dishList![index]);
              },
              childCount: _dishList?.length ?? 0,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.0), // Расстояние между двумя списками
          ),
          
        ],
      ),
    );
  }

  Widget _buildHorizontalCardList() {
    return Container(
      height: 180.0, // Высота списка карточек
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dishList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _buildHorizontalCard(_dishList![index]);
        },
      ),
    );
  }

  Widget _buildHorizontalCard(Dish dish) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 300, // Ширина каждой горизонтальной карточки
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Image.network(
              dish.img_url,
              height: 100.0, // Высота изображения в карточке
              width: 150.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(Dish dish) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image.network(
              dish.img_url,
              height: 130, // Увеличение размера изображения
              width: 130,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    '${dish.price} ₽',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
