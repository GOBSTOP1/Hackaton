import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        title: Text('Профиль',),
        iconTheme: IconThemeData(color:theme.appBarTheme.iconTheme?.color),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications))]),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: ListView(
          
          children: <Widget>[
            ListTile(
              title: Text('Пришелец'),
              leading: Icon(Icons.pages),
              subtitle: Text('89339999187'),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward),),
               contentPadding: EdgeInsets.all(20.0), // Увеличиваем отступы вокруг содержимого
  dense: true, // Уменьшаем вертикальные отступы
            ),
          ],
        ),
    );
  }
}