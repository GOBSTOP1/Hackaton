import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/SnackBar.dart';

class AuthMail extends StatefulWidget {
  const AuthMail({super.key});

  @override
  State<AuthMail> createState() => _AuthMailState();
}

class _AuthMailState extends State<AuthMail> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController = TextEditingController();
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

    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'), iconTheme: IconThemeData(
          color: theme.appBarTheme.iconTheme?.color 
        ),
         backgroundColor: theme.scaffoldBackgroundColor,
         actions: [],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(padding: EdgeInsets.all(30,),
      child: Form(child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            controller: emailTextInputController,
            
            validator: (value){
              if(value != null && value.contains('@')){
                return null;
              } return 'Введите корректный адрес электронной почты';
            } ,
          ),
          const SizedBox(
              height: 30,
            ),
          TextFormField(
            autocorrect: false,
            controller: passwordTextInputController,
            obscureText: isHiddenPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if(value != null && value.length > 6){
                return null;
              } return 'Минимус 6 символов';
            },
            decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Введите пароль',
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
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
              controller: passwordTextRepeatInputController,
              obscureText: isHiddenPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value != null && value.length > 6){
                  return null;
                } return 'Минимум 6 символов';
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Повторите пароль',
                suffix: InkWell(
                  onTap: togglePasswordView,
                  child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                )
              ),

            ),
            const SizedBox(height: 30),
              ElevatedButton(
                onPressed: signUp,
                child: const Center(child: Text('Регистрация')),
              ),
               const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
        ],
      )),
      
      )
    );
  }
}