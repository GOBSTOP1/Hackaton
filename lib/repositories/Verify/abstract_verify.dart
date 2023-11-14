import 'package:flutter/material.dart';

abstract class AbstractVerifyRepository{
  Future<void> signUp({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController repeatPasswordController,
    required GlobalKey<FormState> formKey,
  });
  Future<void> login({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  });
  Future<void> verifyPhoneNumber({
    required TextEditingController numberController, 
    }  );
  Future<void> signInWithCode({required TextEditingController smsController });
}