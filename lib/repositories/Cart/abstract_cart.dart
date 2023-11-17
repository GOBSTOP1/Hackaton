import 'package:hackaton2/repositories/Cart/models/cart.dart';

abstract class AbstractCartRepository{
  Future<List<CartDish>> loadCart();
}