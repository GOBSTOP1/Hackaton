import 'package:flutter/material.dart';
import 'package:hackaton2/repositories/Verify/verify_repository.dart';

import '../../widgets/login/login_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final authService = VerifyRepository();
    await authService.login(
      context: context, 
      emailController:emailTextInputController, 
      passwordController: passwordTextInputController);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: theme.appBarTheme.iconTheme?.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text('Войти'),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: AuthForm(
          formKey: formKey,
          emailController: emailTextInputController,
          passwordController: passwordTextInputController,
          isHiddenPassword: isHiddenPassword,
          onTogglePasswordView: togglePasswordView,
          onLogin: login,
        ),
      ),
    );
  }
}

