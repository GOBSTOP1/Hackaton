import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/repositories/Cart/cart.dart';
import 'package:hackaton2/repositories/Cart/models/cart.dart';
import 'package:hackaton2/services/SnackBar.dart';

import '../../../repositories/Menu/models/menu_dish.dart';

// Импорт сгенерированных частей BLoC
part 'cartEvent.dart';
part 'cartState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final AbstractCartRepository cartRepository;
  
  CartBloc(this.cartRepository,) : super(CartInitial())  {
    
    
    // Вывод сообщения при инициализации BLoC
    

    // Регистрация обработчиков событий
    on<AddToCartEvent>(_handleAddToCartEvent);
    on<RemoveFromCartEvent>(_handleRemoveFromCartEvent);
    on<IncrementCartDishEvent>(_handleIncrementCartDishEvent);
    on<DecrementCartDishEvent>(_handleDecrementCartDishEvent);
  }
  
  // Обработка события добавления товара в корзину
  void _handleAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    CartDish? cartDish;
    bool alreadyInCart = false;
    final cart = await cartRepository.loadCart();
    
    // Поиск товара в корзине
    for (var item in cart) {
      if (item.dish.id == event.dish.id) {
        cartDish = item;
        alreadyInCart = true;
        break;
      }
    }

    // Увеличение количества товара в корзине или добавление нового товара
    if (alreadyInCart) {
      cartDish?.quantity++;
    } else {
      cart.add(event.cartDish);
    }

    // Обновление состояния корзины
    emit(CartLoaded(cart: List.from(cart)));

    // Обновление данных в Firestore
    _updateFirestore(event.dish.id, FieldValue.increment(1));
  }

  // Обработка события удаления товара из корзины
  void _handleRemoveFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    final cartCollection = FirebaseFirestore.instance.collection('cart');
    final cart = await cartRepository.loadCart();

    // Поиск документа с текущим userUid
    final foundDoc = await cartCollection.where('userUid', isEqualTo: userUid).get();

    if (foundDoc.docs.isNotEmpty) {
      final docId = foundDoc.docs.first.id;

      // Удаление товара из основной коллекции корзины
      cart.removeWhere((item) => item.dish.id == event.dish.id);
      emit(CartLoaded(cart: List.from(cart)));

      // Удаление соответствующего документа из подколлекции items
      final itemDoc = await cartCollection
          .doc(docId)
          .collection('items')
          .where('dishId', isEqualTo: event.dish.id)
          .get();

      if (itemDoc.docs.isNotEmpty) {
        final itemId = itemDoc.docs.first.id;
        await cartCollection
            .doc(docId)
            .collection('items')
            .doc(itemId)
            .delete();
      }
    }
  }

  // Обработка события увеличения количества товара в корзине
  void _handleIncrementCartDishEvent(IncrementCartDishEvent event, Emitter<CartState> emit) async {
    final cart = await cartRepository.loadCart();
   
    final CartDish cartDish = cart.firstWhere((item) => item.dish.id == event.dish.id);

    // Проверка допустимого количества товара
    if (cartDish.quantity >= 1 && cartDish.quantity < 30) {
      cartDish.quantity++;

      // Обновление состояния корзины
      emit(CartLoaded(cart: cart.toList()));

      // Обновление данных в Firestore
      _updateFirestore(event.dish.id, FieldValue.increment(1));
    }
  }

  // Обработка события уменьшения количества товара в корзине
  void _handleDecrementCartDishEvent(DecrementCartDishEvent event, Emitter<CartState> emit) async {
    final cart = await cartRepository.loadCart();
   
    final CartDish cartDish = cart.firstWhere((item) => item.dish.id == event.dish.id);
    
    // Уменьшение количества товара или удаление, если оно достигло 1
    if (cartDish.quantity == 1) {
      // Удаление товара из корзины
      cart.removeWhere((item) => item.dish.id == event.dish.id);
      _updateFirestore(event.dish.id, null);
    } else {
      cartDish.quantity--;

      // Обновление состояния корзины
      emit(CartLoaded(cart: List.from(cart)));

      // Обновление данных в Firestore
      _updateFirestore(event.dish.id, FieldValue.increment(-1));
    }
  }

  // Обновление данных в Firestore
  void _updateFirestore(String dishId, dynamic value) async {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    final cartCollection = FirebaseFirestore.instance.collection('cart');
    final foundDoc = await cartCollection.where('userUid', isEqualTo: userUid).get();
    
    if (foundDoc.docs.isNotEmpty) {
      final docId = foundDoc.docs.first.id;
      final itemDoc = await cartCollection.doc(docId).collection('items').where('dishId', isEqualTo: dishId).get();

      if (itemDoc.docs.isNotEmpty) {
        final itemId = itemDoc.docs.first.id;

        if (value != null) {
          await cartCollection.doc(docId).collection('items').doc(itemId).update({'counter': value});
        } else {
          await cartCollection.doc(docId).collection('items').doc(itemId).delete();
        }
      }
    }
  }
}
