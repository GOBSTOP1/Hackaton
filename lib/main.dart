
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';
import 'package:hackaton2/repositories/Menu/menu.dart';
import 'firebase_options.dart';
import 'myApp.dart';

Future <void> main() async {
  GetIt.I.registerLazySingleton<AbstractMenuRepository>(() => MenuRepository());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

