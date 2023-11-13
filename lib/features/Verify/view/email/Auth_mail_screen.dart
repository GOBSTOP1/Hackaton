import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/features/Verify/Verify.dart';

import '../../../../services/SnackBar.dart';
import '../../widgets/email/Auth_mail_widget.dart';

class AuthMail extends StatefulWidget {
  const AuthMail({super.key});

  @override
  State<AuthMail> createState() => _AuthMailState();
}

class _AuthMailState extends State<AuthMail> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
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

    navigator.pushNamedAndRemoveUntil('/verifyMail', (Route<dynamic> route) => false,
    arguments: {
    'email': emailTextInputController.text.trim(),
    
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = emailTextInputController.text.trim();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Регистрация'),
          iconTheme: IconThemeData(color: theme.appBarTheme.iconTheme?.color),
          backgroundColor: theme.scaffoldBackgroundColor,
          actions: [],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: RegistrationForm(
    emailController: emailTextInputController,
    passwordController: passwordTextInputController,
    repeatPasswordController: passwordTextRepeatInputController,
    isHiddenPassword: isHiddenPassword,
    togglePasswordView: togglePasswordView,
    formKey: formKey,
    signUp: signUp,
  ),
        );
  }
}
