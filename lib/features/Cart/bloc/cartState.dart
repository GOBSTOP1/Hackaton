part of 'cartBloc.dart';

abstract class CartState {}

class CartInitial implements CartState {}

class CartEmpty implements CartState {}

class CartIsNotEmpty implements CartState {
  final List<CartDish> cartItems;

  CartIsNotEmpty({required this.cartItems});
}
