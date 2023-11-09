
import 'package:hackaton2/screens/HomeBar.dart';
import 'package:hackaton2/screens/verify/mail/AuthMail.dart';
import 'package:hackaton2/services/FireBaseStreem.dart';
import '../screens/screens.dart';


final routes = {
  '/': (context) => const HomeBar(),
  '/login': (context) => const Login(),
  '/firebaseStreem': (context) => const FireBaseStreem(),
  '/authMail': (context) => const AuthMail(),
};