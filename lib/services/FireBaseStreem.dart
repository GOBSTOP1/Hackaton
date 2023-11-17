import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../features/HomeBar/view/view.dart';
import '../features/Verify/Verify.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          print('Snapshot: $snapshot');
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            print('Has Data: ${snapshot.data}');
            if (user == null) {
              // Future.delayed(Duration.zero, () {
              //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              //    });
              return const Login();
            } else {
              return const HomeBar();
            }
          } else if (snapshot.hasError) {
            return const Login();
          } else {
            return const Login();
          }
        });
  }
}
