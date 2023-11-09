import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/screens/HomeBar.dart';
import 'package:hackaton2/screens/screens.dart';


class FireBaseStreem extends StatelessWidget {
  const FireBaseStreem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(), 
    builder: ((context, snapshot) {
      if (snapshot.hasError){
      return const Login();
      } else if (snapshot.hasData) {
       if (snapshot.data!.emailVerified){
         return const Login();
       } return const HomeBar();
      } else {
        return const Login();
      }                                       
    }));
  }
}