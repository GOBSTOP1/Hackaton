import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isHiddenPassword,
    required this.onTogglePasswordView,
    required this.onLogin,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isHiddenPassword;
  final VoidCallback onTogglePasswordView;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Form(
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
              return 'Введите действительный адрес электронной почты';
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Введите Email',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            controller: passwordController,
            obscureText: isHiddenPassword,
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              } else if (value == null || value.length < 6) {
                return 'Минимум 6 символов';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Введите пароль',
              suffix: InkWell(
                onTap: onTogglePasswordView,
                child: Icon(
                  isHiddenPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onLogin,
            child: Center(child: Text('Войти', style: Theme.of(context).textTheme.bodyMedium)),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/authMail'),
            style: Theme.of(context).textButtonTheme.style,
            child: Text(
              'Зарегистрироваться',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/reset_password'),
            style: Theme.of(context).textButtonTheme.style,
            child: Text(
              'Сбросить пароль',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
