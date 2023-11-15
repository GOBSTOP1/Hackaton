
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль',),
        iconTheme: IconThemeData(color:theme.appBarTheme.iconTheme?.color),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))]),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const ListViewAccount(),
    );
  }
}

