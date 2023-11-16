import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';

import 'models/menu_dish.dart';

class MenuRepository implements AbstractMenuRepository {
  @override
  Future<List<Dish>> loadMenu() async {
    try {
      final db = FirebaseFirestore.instance;
      final userUid = FirebaseAuth.instance.currentUser?.uid;

      

      // Получаем foodprovider_id из документа пользователя
      // final userDoc = await db.collection("users").doc().get();
      // final organisationId = userDoc['organisation_id'];

      // if (foodProviderId == null) {
      //   throw Exception("foodprovider_id not found for the user");
      // }

      // Используем полученный foodprovider_id для фильтрации блюд
      // final response =
      //     await db.collection("menu").where('foodprovider_id', isEqualTo: foodProviderId).get();
      final response = await db.collection("menu").get();

      List<Dish> menuList = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data();

        return Dish(
          id: doc.id,
          name: data['name'] ?? '',
          price: data['price']?.toDouble() ?? 0.0,
          img_url: data['img_url'] ?? '',
          description: data['description'] ?? '',
          type: data['type'] ?? '',
        );
      }).toList();

      for (var dish in menuList) {
        print(
            "${dish.id} => ${dish.name} ${dish.price} ${dish.img_url} ${dish.description} ${dish.type} ");
      }

      return menuList;
    } catch (e) {
      print("Error loading menu: $e");
      
      return [];
    }
  }
}
