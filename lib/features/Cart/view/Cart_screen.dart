import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/features/Cart/bloc/cartBloc.dart';
import 'package:hackaton2/repositories/Cart/abstract_cart.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';
import 'package:hackaton2/services/SnackBar.dart';

import '../../../repositories/Cart/models/cart.dart';
// Укажите путь к вашему файлу с Bloc

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    
    final _cartBloc = CartBloc(GetIt.I<AbstractCartRepository>());

    return BlocProvider(
      create: (context) => _cartBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          bloc: _cartBloc,
          builder: (context, state) {
            if (state is CartLoaded) {
              return buildCartList(state.cart);
            }
            if (state is CartInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget buildCartList(List<CartDish> cart) {
    final cartBloc = GetIt.I<CartBloc>();
    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final cartDish = cart[index];
        return ListTile(
          leading: Image.network(cartDish.dish.img_url),
          title: Text(cartDish.dish.name),
          trailing: SizedBox(
            width: 150,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cartBloc.add(DecrementCartDishEvent(dish: cartDish.dish));
                  },
                ),
                Text('${cartDish.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if(cartDish.quantity >= 30){
                      SnackBarService.showSnackBar(context, 'Ошибка:Больше 30 нельзя', true);
                    }
                    cartBloc.add(IncrementCartDishEvent(dish: cartDish.dish));
                    
                  },
                ),
                IconButton(
                    onPressed: () {
                      cartBloc.add(RemoveFromCartEvent(dish: cartDish.dish));
                    },
                    icon: Icon(Icons.track_changes))
              ],
            ),
          ),
        );
      },
    );
  }
}
