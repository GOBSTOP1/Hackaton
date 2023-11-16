import 'package:flutter/material.dart';

class RegistationPhoneForm extends StatefulWidget {
  const RegistationPhoneForm(
      {super.key,
      required this.phoneController,
      required this.formKey,
      required this.signUp,
      required this.smsController,
      required this.signInWithCode});
  final TextEditingController phoneController;
  final TextEditingController smsController;
  final GlobalKey<FormState> formKey;
  final Function signUp;
  final Function signInWithCode;

  @override
  State<RegistationPhoneForm> createState() => _RegistationPhoneFormState();
}

class _RegistationPhoneFormState extends State<RegistationPhoneForm> {
  bool isSmsCodeSent = false;
  Future<void> _verifyPhoneNumber() async {
    await widget.signUp(numberController: widget.phoneController);
  }

  Future<void> _signInWithCode() async {
    await widget.signInWithCode(smsController: widget.smsController);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              autocorrect: false,
              controller: widget.phoneController,
              validator: (value) {
                if (value != null && value.length < 11) {
                  return 'Введите корректный номер телефона';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  if (!isSmsCodeSent) {
                    setState(() {
                      isSmsCodeSent =
                          true; // Устанавливаем флаг после отправки кода
                    });
                    _verifyPhoneNumber();
                  } else {
                    // Обработка повторного нажатия после отправки кода, если нужно
                  }
                },
                child: const Text('Отправить код')),
            if (isSmsCodeSent)
              TextFormField(
                keyboardType: TextInputType.number,
                autocorrect: false,
                controller: widget.smsController,
                validator: (value) {
                  return null;
                },
              ),
            if (isSmsCodeSent)
              ElevatedButton(
                onPressed: () {
                  _signInWithCode();
                },
                child: const Text('Подтвердить'),
              ),
          ],
        ));
  }
}
