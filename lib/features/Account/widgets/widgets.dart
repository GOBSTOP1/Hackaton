import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

    navigator.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Пришелец'),
          leading: const Icon(Icons.pages),
          subtitle: const Text('89339999187'),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
          ),
          contentPadding: const EdgeInsets.all(
              20.0), // Увеличиваем отступы вокруг содержимого
          dense: true,
        ),
        ListTile(
          title: IconButton(
              onPressed: () => signOut(), icon: const Icon(Icons.exit_to_app)),
          trailing: IconButton(
            onPressed: () => MenuRepository().loadMenu(),
            icon: const Icon(Icons.download),
          ),
        ),
        ListTile(
          title: Text(
            'Настройки',
            style: theme.textTheme.bodyMedium,
          ),
          trailing: const Icon(Icons.forward),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: Icon(Icons.dangerous),
          title: Text(
            'Выбрать организацию',
            style: theme.textTheme.bodyMedium,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/choseOrg');
          },
        )
      ],
    );
  }
}
