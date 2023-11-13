import 'package:flutter/material.dart';

class ListViewAccount extends StatelessWidget {
  const ListViewAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}