
import 'package:hackaton2/features/HomeBar/HomeBar.dart';
import 'package:hackaton2/services/FireBaseStreem.dart';
import '../features/Verify/Verify.dart';


final routes = {
  '/': (context) => const HomeBar(),
  '/login': (context) => const Login(),
  '/firebaseStreem': (context) => const FirebaseStream(),
  '/authMail': (context) => const AuthMail(),
  '/verifyMail': (context) =>  const VerifyMail(),
};