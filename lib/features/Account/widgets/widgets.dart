import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';
import 'package:hackaton2/repositories/Menu/menu_repository.dart';

class ListViewAccount extends StatefulWidget {
  const ListViewAccount({
    super.key,
  });

  @override
  State<ListViewAccount> createState() => _ListViewAccountState();
}

class _ListViewAccountState extends State<ListViewAccount> {

 Future<void> signOut() async {
    

  final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return ListView(
      
      children: <Widget>[
        
        ListTile(
          title: Text('Пришелец'),
          leading: Icon(Icons.pages),
          subtitle: Text('89339999187'),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward),),
           contentPadding: EdgeInsets.all(20.0), // Увеличиваем отступы вокруг содержимого
  dense: true, // Уменьшаем вертикальные отступы
        ),
        ListTile(
          title: IconButton(onPressed: () => signOut(), icon:Icon(Icons.exit_to_app)),
          trailing: IconButton(onPressed: () => MenuRepository().loadMenu(), icon: Icon(Icons.download),),
        ),
        ListTile(
          title: Text('Настройки',style: theme.textTheme.bodyMedium,),
          trailing: Icon(Icons.forward),
          onTap: (){Navigator.pushNamed(context, '/settings');},
        )
      ],
    );
  }
}