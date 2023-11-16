import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/features/Menu/bloc/menuBloc.dart';
import 'package:hackaton2/features/Menu/newsScreen/bloc/newsBloc.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';
import 'package:hackaton2/repositories/News/abstract_news.dart';

import '../../../repositories/Menu/models/menu_dish.dart';
import '../../Cart/bloc/cartBloc.dart';
import '../widgets/widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _menuBloc = MenuBloc(GetIt.I<AbstractMenuRepository>());
  final _newsBloc = NewsBloc(GetIt.I<AbstractNewsRepository>());
  final _cartBloc = CartBloc();

  @override
  void initState() {
    _newsBloc.add((LoadNewsEvent()));
    _menuBloc.add((LoadMenuEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuBloc, MenuState>(
        bloc: _menuBloc,
        builder: (context, state) {
          if (state is MenuLoaded) {
            return CustomScrollView(
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
                    child: BlocBuilder<NewsBloc, NewsState>(
                        bloc: _newsBloc,
                        builder: (context, state) {
                          if (state is NewsLoaded) {
                            return NewsHorizontalCardList(
                                newsList: state.newsList);
                          }

                          return Container();
                        })),
                BlocProvider.value(
                  value: _cartBloc,
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return MenuItemCard(dish: state.dishList[index]);
                      },
                      childCount: state.dishList.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20.0),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
