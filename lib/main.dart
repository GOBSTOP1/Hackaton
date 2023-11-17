import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/features/Cart/bloc/cartBloc.dart';
import 'package:hackaton2/repositories/Account/Organisation/organisation.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';
import 'package:hackaton2/repositories/News/abstract_news.dart';
import 'package:hackaton2/repositories/News/news_repository.dart';
import 'firebase_options.dart';
import 'myApp.dart';

Future<void> main() async {
  GetIt.I.registerLazySingleton<AbstractMenuRepository>(() => MenuRepository());
  GetIt.I.registerLazySingleton<AbstractNewsRepository>(() => NewsRepository());
  GetIt.I.registerLazySingleton<AbstractOrganisationRepository>(
      () => OrganisationRepository());
  GetIt.I.registerLazySingleton<CartBloc>(() => CartBloc());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
