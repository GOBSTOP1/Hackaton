import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/features/Cart/models/cart.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';
part 'cartEvent.dart';
part 'cartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<AddToCartEvent>((event, emit) {});
    on<RemoveFromCartEvent>((event, emit) {});
    on<IncrementCartDishEvent>((event, emit) {});
  }
}
