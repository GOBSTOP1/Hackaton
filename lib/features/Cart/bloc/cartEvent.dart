part of 'cartBloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartDish cartDish;
  final Dish dish;

  AddToCartEvent({required this.cartDish, required this.dish});
}

class RemoveFromCartEvent extends CartEvent {
  final Dish dish;

  RemoveFromCartEvent({required this.dish});
}

class IncrementCartDishEvent implements CartEvent {
  final Dish dish;

  IncrementCartDishEvent({required this.dish});
}

class DecrementCartDishEvent implements CartEvent {
  final Dish dish;

  DecrementCartDishEvent({required this.dish});
}
