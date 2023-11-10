import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/services/SnackBar.dart';

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
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextInputController.text.trim(), 
      password:passwordTextInputController.text.trim(),);
      

    } on FirebaseAuthException catch (e){
      print('ЯТУТ');
      print(e.code, );
      if (e.code == 'user-not-found' || e.code == 'wrong-password'){
      SnackBarService.showSnackBar(context, 'Неправильный email или пароль', true,);
      return;
      } else {
         SnackBarService.showSnackBar(
          context,
          'Неправильный email или пароль',
          true,
        );
        return;
      }

    
    }
    navigator.pushNamedAndRemoveUntil('/', (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: theme.appBarTheme.iconTheme?.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        title:  Text('Войти'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (value) {
                if (value != null && value.contains('@')) {
                  return null;
                }
                return 'Введите действительный адрекс электронной почты';
              },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите Email',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                validator: (value) {
                if (value != null && value.length > 6) {
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (){login();},
                child:  Center(child: Text('Войти',style: theme.textTheme.bodyMedium)),
                
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/authMail'),
                child:  Text(
                  'Зарегестрироваться',
                 style: theme.textTheme.bodySmall,
                ),
                style: theme.textButtonTheme.style,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/reset_password'),
                child:  Text('Сбросить пароль',style: theme.textTheme.bodySmall,),
                style: theme.textButtonTheme.style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
