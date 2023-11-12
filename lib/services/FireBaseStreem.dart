import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/screens/HomeBar.dart';
import 'package:hackaton2/screens/screens.dart';
import 'package:hackaton2/services/SnackBar.dart';


// class FireBaseStreem extends StatelessWidget {
//   const FireBaseStreem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//     stream: FirebaseAuth.instance.authStateChanges(), 
//     builder: (context, snapshot) {
//       if (snapshot.hasError){
//       return const Scaffold(
//          body: Center(child: Text('Что-то пошло не так!'))
//       );
//       } else if (snapshot.hasData) {
//        if (!snapshot.data!.emailVerified){
//         print('сработала проверка на код почты');
//         Future.delayed(Duration.zero, () {
//               Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//             });
//        }
//        print('СРаботал хомбар');
//        return const HomeBar();
//       } else {
//         print('Сработал delyaed в логине2 ');
//        Future.delayed(Duration.zero, () {
//               Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//             });
//             print('Сработал return const Login();');
//         return const Login();
//         //  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//       }                                       
//     });
//   }
// }
// class FirebaseStream extends StatelessWidget {
//   const FirebaseStream({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         print('Snapshot: $snapshot');  // Добавленная инструкция
        
//         if (snapshot.hasError ) {
//           return const Scaffold(
//               body: Center(child: Text('Что-то пошло не так!')));
//         } else if (snapshot.hasData) {
//           print('Has Data: ${snapshot.data}');  // Добавленная инструкция
//           if (!snapshot.data!.emailVerified) {
//             print('сработал логин 3');
//             return const Login();
//           }
//           print('Сработал хомбар');
//           return const HomeBar();
//         } else {
//           print('сработал логин 4');
//           return const Login();
//         }
//       },
//     );
//   }
// }
class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
    
    stream: FirebaseAuth.instance.userChanges(), 
    builder: (context, snapshot){
    print('Snapshot: $snapshot'); 
     if(snapshot.connectionState == ConnectionState.active){
      User? user = snapshot.data;
      print('Has Data: ${snapshot.data}');
      if(user == null ){
          // Future.delayed(Duration.zero, () {
          //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          //    });
        return const Login();
      } else {
        
        return const HomeBar();
      } 
     } else if (snapshot.hasError){
      
      return const Login();
     }  else  {
      return const Login();
     }
    }
    );
  }
}
