part of 'cartBloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartDish> cart;

  CartLoaded({required this.cart});
}
