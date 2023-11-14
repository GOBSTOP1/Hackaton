
import 'models/menu_dish.dart';

abstract class AbstractMenuRepository{
  Future<List<Dish>> loadMenu();
}