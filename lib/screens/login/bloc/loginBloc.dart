// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hackaton2/screens/screens.dart';

// part 'loginEvent.dart';
// part 'loginState.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitial()) {
//     on<LoginEvent>(Login as EventHandler<LoginEvent, LoginState>);
//   }
//   Future<void> Login(
//     String email,
//     String password,
//     LoginEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     try {
//       if (state is! LoginSucces) {
//         emit(LoginLoading());
//       }
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       emit(LoginSucces());
//     } on FirebaseAuthException catch (e) {
//       emit(LoginFail());
//     }
//   }
// }
