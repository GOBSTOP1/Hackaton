import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/screens/HomeBar.dart';
import 'package:hackaton2/screens/screens.dart';


class FireBaseStreem extends StatelessWidget {
  const FireBaseStreem({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context, snapshot) {
      if (snapshot.hasError){
      return const Scaffold(
         body: Center(child: Text('Что-то пошло не так!'))
      );
      } else if (snapshot.hasData) {
       if (!snapshot.data!.emailVerified){
        Future.delayed(Duration.zero, () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            });
          // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          return const HomeBar();
       } 
      } else {
       Future.delayed(Duration.zero, () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            });
        return const Login();
        //  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }                                       
    });
  }
}