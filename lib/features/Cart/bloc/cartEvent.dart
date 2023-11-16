part of 'cartBloc.dart';

abstract class CartEvent {}

class AddToCartEvent implements CartEvent {
  final Dish dish;
  AddToCartEvent(this.dish);
}

class RemoveFromCartEvent implements CartEvent {
  final String dishId;

  RemoveFromCartEvent(this.dishId);
}

class IncrementCartDishEvent implements CartEvent {
  final String dishId;

  IncrementCartDishEvent({required this.dishId});
}

class DecrementCartDishEvent implements CartEvent {
  final String dishId;

  DecrementCartDishEvent({required this.dishId});
}
