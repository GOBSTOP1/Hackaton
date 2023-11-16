import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cartBloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cartBloc,
      child: CartWidget(),
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Корзина',
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: theme.appBarTheme.iconTheme?.color,
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartEmpty) {
              return Container();
            } else if (state is CartIsNotEmpty) {
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  final cartDish = state.cartItems[index];
                  return ListTile(
                    title: Text(cartDish.dish.name),
                    subtitle: Text('Количество: ${cartDish.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<CartBloc>().add(DecrementCartDishEvent(
                                dishId: cartDish.dish.id));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<CartBloc>().add(IncrementCartDishEvent(
                                dishId: cartDish.dish.id));
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                  child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      Text(
                        'В корзине пусто',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        'Выберите блюда из меню',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  )),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Перейти в меню',
                      style: theme.textTheme.bodyMedium,
                    ),
                    style: theme.textButtonTheme.style,
                  ),
                ],
              ));
            }
          },
        ));
  }
}
