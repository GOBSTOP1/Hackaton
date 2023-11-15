


import 'package:hackaton2/features/Account/view/Organisation/organisation.dart';
import 'package:hackaton2/features/Account/view/settings/Settings.dart';
import 'package:hackaton2/features/Account/view/settings/ThemeAppSreen.dart';
import 'package:hackaton2/features/HomeBar/HomeBar.dart';
import 'package:hackaton2/features/Menu/Menu.dart';
import 'package:hackaton2/services/FireBaseStreem.dart';
import '../features/Verify/Verify.dart';


final routes = {
  '/': (context) => const HomeBar(),
  '/login': (context) => const Login(),
  '/firebaseStreem': (context) => const FirebaseStream(),
  '/authMail': (context) => const AuthMail(),
  '/verifyMail': (context) =>  const VerifyMail(),
  '/authPhone': (context) => const PhoneScreen(),
  '/menu': (context) => const Menu(),
  '/settings': (context) => const SettingsScreen(),
  '/themeApp':(context) => const ThemeAppScreen(),
  '/organisationChose': (context) => const OrganisationScreen(),
};