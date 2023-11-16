import 'package:flutter/material.dart';
import 'package:hackaton2/features/Verify/widgets/phone/phone_widget.dart';
import 'package:hackaton2/repositories/Verify/verify.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final VerifyRepository _verifyRepository = VerifyRepository();
  TextEditingController phoneNumberInpitController = TextEditingController();
  TextEditingController smsInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    phoneNumberInpitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        iconTheme: IconThemeData(color: theme.appBarTheme.iconTheme?.color),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: const [],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RegistationPhoneForm(
        phoneController: phoneNumberInpitController,
        formKey: formKey,
        signUp: _verifyRepository.verifyPhoneNumber,
        smsController: smsInputController,
        signInWithCode: _verifyRepository.signInWithCode,
      ),
    );
  }
}
