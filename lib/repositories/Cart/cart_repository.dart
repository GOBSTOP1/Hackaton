

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackaton2/repositories/Cart/cart.dart';
import 'package:hackaton2/repositories/Cart/models/cart.dart';

class CartRepository implements AbstractCartRepository{
  @override
  Future<List<CartDish>> loadCart() async {
    try{
      
      final userUid = FirebaseAuth.instance.currentUser?.uid;
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      final response = await cartCollection.where('userUid', isEqualTo: userUid).get();
      List<CartDish> cartList = response.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return CartDish(
          dish: data['dishId'], quantity: data['counter']);
      }).toList();
      return cartList;
    } catch (e) {
      return [];
    }
  }
}