import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/email/emailBloc.dart';

class RegistrationForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final bool isHiddenPassword;
  final Function togglePasswordView;
  final GlobalKey<FormState> formKey;
  final Function signUp;

  const RegistrationForm({
    required this.emailController,   
    required this.passwordController,
    required this.repeatPasswordController,
    required this.isHiddenPassword,
    required this.togglePasswordView,
    required this.formKey,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              controller: emailController,
              validator: (value) {
                if (value != null && value.contains('@')) {
                  return null;
                }
                return 'Введите корректный адрес электронной почты';
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите Email',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              controller: passwordController,
              obscureText: isHiddenPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                }
                return 'Минимус 6 символов';
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Введите пароль',
                suffix: InkWell(
                  onTap: togglePasswordView(),
                  child: Icon(
                    isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              controller: repeatPasswordController,
              obscureText: isHiddenPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != null && value.length >= 6) {
                  return null;
                }
                return 'Минимум 6 символов';
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Повторите пароль',
                suffix: InkWell(
                  onTap: togglePasswordView(),
                  child: Icon(
                    isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                signUp();
              },
              child: Center(
                child: Text('Регистрация'),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
