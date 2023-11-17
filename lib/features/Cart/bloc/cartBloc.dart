import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/features/Cart/models/cart.dart';

import '../../../repositories/Menu/models/menu_dish.dart';

part 'cartEvent.dart';
part 'cartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    print('AddToCartEvent registered, ${cart.length} ${cart}');
    on<AddToCartEvent>((AddToCartEvent event, Emitter<CartState> emit) async {
      CartDish? cartDish;
      bool alreadyInCart = false;

      for (var item in cart) {
        if (item.dish.id == event.dish.id) {
          cartDish = item;
          alreadyInCart = true;
          break;
        }
      }

      if (alreadyInCart) {
        // Товар уже в корзине, увеличиваем количество
        cartDish?.quantity++;
      } else {
        // Товара нет в корзине, добавляем новый
        cart.add(event.cartDish);
      }

      emit(CartLoaded(cart: List.from(cart)));
      final userUid = FirebaseAuth.instance.currentUser?.uid;
      final cartCollection = FirebaseFirestore.instance.collection('cart');
      final foundDoc =
          await cartCollection.where('userUid', isEqualTo: userUid).get();

      // Проверяем, есть ли документ с текущим userUid
      if (foundDoc.docs.isNotEmpty) {
        final docId = foundDoc.docs.first.id;

        // Проверяем, есть ли документ в подколлекции items с тем же dishId
        final itemDoc = await cartCollection
            .doc(docId)
            .collection('items')
            .where('dishId', isEqualTo: event.dish.id)
            .get();

        if (itemDoc.docs.isNotEmpty) {
          // Если документ существует, увеличиваем counter на 1
          final itemId = itemDoc.docs.first.id;
          await cartCollection
              .doc(docId)
              .collection('items')
              .doc(itemId)
              .update({
            'counter': FieldValue.increment(1),
          });
        } else {
          // Если документ не существует, добавляем новый с dishId и counter = 1
          await cartCollection.doc(docId).collection('items').add({
            'dishId': event.dish.id,
            'counter': 1,
          });
        }
      } else {
        // Создаем новый документ с текущим userUid
        final newDocRef = await cartCollection.add({
          'userUid': userUid,
        });

        // Добавляем dish.id в подколлекцию items с counter = 1
        await newDocRef.collection('items').add({
          'dishId': event.dish.id,
          'counter': 1,
        });
      }
    });

    on<RemoveFromCartEvent>(
        (RemoveFromCartEvent event, Emitter<CartState> emit) async {
      cart.removeWhere((item) => item.dish.id == event.dish.id);
      emit(CartLoaded(cart: List.from(cart)));

      final userUid = FirebaseAuth.instance.currentUser?.uid;
      final cartCollection = FirebaseFirestore.instance.collection('cart');

      final cartDoc = await cartCollection.doc(userUid).get();
      if (cartDoc.exists) {
        // Обновляем запись в Firestore, удаляя информацию о блюде из подколлекции items

        await cartCollection.doc(userUid).update({
          'items': FieldValue.arrayRemove([
            {
              'dishId': event.dish.id,
            }
          ])
        });
      }
    });

    on<IncrementCartDishEvent>(
        (IncrementCartDishEvent event, Emitter<CartState> emit) {
      final CartDish cartDish =
          cart.firstWhere((item) => item.dish.id == event.dish.id);
      print(
          ' инкремент товара ${cartDish} ${cartDish.quantity} ${cartDish.dish} ${cartDish.dish.id}');
      if (cartDish.quantity <= 1) {
        cartDish.quantity++;
      }
      print('Инкрмент отработал');
      emit(CartLoaded(cart: cart.toList()));
    });

    on<DecrementCartDishEvent>(
        (DecrementCartDishEvent event, Emitter<CartState> emit) {
      final CartDish cartDish =
          cart.firstWhere((item) => item.dish.id == event.dish.id);
      print(
          'декремент товара ${cartDish} ${cartDish.quantity} ${cartDish.dish} ${cartDish.dish.id}');
      if (cartDish.quantity == 1) {
        cart.removeWhere((item) => item.dish.id == event.dish.id);
      } else {
        cartDish.quantity--;
      }

      print('декремент отработал');
      emit(CartLoaded(cart: List.from(cart)));
    });
  }
  final List<CartDish> cart = [];
}
