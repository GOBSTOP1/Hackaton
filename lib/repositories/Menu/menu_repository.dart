
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';

import 'models/menu_dish.dart';

class MenuRepository implements AbstractMenuRepository{
  
  @override
  Future<List<Dish>> loadMenu() async {
  try {
    final db = FirebaseFirestore.instance;
    final response = await db.collection("menu").get();
    
    List<Dish> menuList = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
       
        return Dish(
          id: doc.id,
          name: data['name'] ?? '',
          price: data['price']?.toDouble() ?? 00,
          img_url: data['img_url'] ?? '',
          description: data['description'] ?? '',
          type: data['type'] ?? '',
        );
      }).toList();
         for (var dish in menuList) {
        print("${dish.id} => ${dish.name} ${dish.price} ${dish.img_url} ${dish.description} ${dish.type} ");
      }
      return menuList;
    
  } catch (e) {
    print("Error loading menu: $e");
    // Доделать обработку ошибок(желательно)
    return [];
  }
  
}

}