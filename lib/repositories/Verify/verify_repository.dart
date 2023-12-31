import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hackaton2/repositories/Verify/abstract_verify.dart';
import 'package:hackaton2/services/SnackBar.dart';

class VerifyRepository implements AbstractVerifyRepository {
  String? verificationId;
  @override
  Future<void> signUp({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController repeatPasswordController,
    required GlobalKey<FormState> formKey,
  }) async {
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (passwordController.text != repeatPasswordController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    navigator.pushNamed(
      '/verifyMail',
      arguments: {
        'email': emailController.text.trim(),
      },
    );
  }

  @override
  Future<void> login({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    const isValid = true; // Add your validation logic here
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } on FirebaseAuthException {
      SnackBarService.showSnackBar(
        context,
        'Неправильный email или пароль',
        true,
      );
    }
  }

  @override
  Future<void> verifyPhoneNumber({
    required TextEditingController numberController,
  }) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user (only on Android)
          await FirebaseAuth.instance.signInWithCredential(credential);
          // Handle verification completed
        },
        verificationFailed: (FirebaseAuthException e) {},
        // codeSent: (String verificationId, int? resendToken) {},
        codeSent: (String verificationId, int? resendToken) {
          // Сохранить verificationId в классе
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: numberController.text.trim(),
      );
    } catch (e) {}
  }

  @override
  Future<void> signInWithCode(
      {required TextEditingController smsController}) async {
    try {
      if (verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId!,
            smsCode: smsController.text.trim());
        await FirebaseAuth.instance.signInWithCredential(credential);
        verificationId = null;
      }
    } catch (e) {}
  }
}
