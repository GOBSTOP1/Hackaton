import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/repositories/Cart/models/cart.dart';
import 'package:hackaton2/repositories/Menu/models/menu_dish.dart';
import 'package:hackaton2/repositories/News/models/models.dart';

import '../../../services/SnackBar.dart';
import '../../Cart/bloc/cartBloc.dart';

class NewsHorizontalCardList extends StatelessWidget {
  final List<News> newsList;

  const NewsHorizontalCardList({required this.newsList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsList.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsHorizontalCard(news: newsList[index]);
        },
      ),
    );
  }
}

class NewsHorizontalCard extends StatelessWidget {
  final News news;

  const NewsHorizontalCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 300,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            news.imgUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final Dish dish;

  const MenuItemCard({required this.dish, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Image.network(
                  dish.img_url,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        '${dish.price} ₽',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {
            // final userUid = FirebaseAuth.instance.currentUser?.uid;
            // final cartCollection =
            //     FirebaseFirestore.instance.collection('cart');
            // final foundDoc =
            //     await cartCollection.where('userUid', isEqualTo: userUid).get();

            // // Проверяем, есть ли документ с текущим userUid
            // if (foundDoc.docs.isNotEmpty) {
            //   final docId = foundDoc.docs.first.id;
            //   // Добавляем dish.id в подколлекцию items
            //   await cartCollection.doc(docId).collection('items').add({
            //     'dishId': dish.id,
            //     'counter': 1,
            //   });
            // } else {
            //   // Создаем новый документ с текущим userUid
            //   final newDocRef = await cartCollection.add({
            //     'userUid': userUid,
            //   });

            //   // Добавляем dish.id в подколлекцию items
            //   await newDocRef.collection('items').add({
            //     'dishId': dish.id,
            //     'counter': 1,
            //   });
            // }

            print('Товар добавлен в корзину');
            SnackBarService.showSnackBar(context,
                'Товар добавлен в корзину ${dish.id}, ${dish.name}', false);

            final cartBloc = GetIt.I<CartBloc>();
            cartBloc.add(AddToCartEvent(
                cartDish: CartDish(dish: dish, quantity: 1), dish: dish));
          },
        ));
  }
}
