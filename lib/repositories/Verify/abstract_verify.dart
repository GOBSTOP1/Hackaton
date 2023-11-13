import 'package:flutter/material.dart';

abstract class AbstractVerifyRepository{
  Future<void> signUp({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController repeatPasswordController,
    required GlobalKey<FormState> formKey,
  });
}