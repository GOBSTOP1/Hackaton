import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/themeData/bloc/themebloc.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen ({super.key});

  @override
  State<SettingsScreen > createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen > {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Настройки"),
          iconTheme: IconThemeData(
            color: theme.appBarTheme.iconTheme?.color,
          ),
           backgroundColor: theme.scaffoldBackgroundColor,
        ),
         backgroundColor: theme.scaffoldBackgroundColor,
        body:  ListView(
                children: [
                  ListTile(
                  title: Text('Тема приложения',style: theme.textTheme.bodyMedium,),
                  trailing: Icon(Icons.arrow_forward), 
                  onTap: (){Navigator.pushNamed(context, '/themeApp');},
                  ),
                  
                ],
              )
    );
            }
          
        
        
  }

