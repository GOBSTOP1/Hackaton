import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../themeData/bloc/themebloc.dart';
import '../../../../themeData/theme.dart';

class ThemeAppScreen extends StatefulWidget {
  const ThemeAppScreen({super.key});

  @override
  State<ThemeAppScreen> createState() => _ThemeAppScreenState();
}

class _ThemeAppScreenState extends State<ThemeAppScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тема приложения'),
        iconTheme: IconThemeData(
          color: theme.appBarTheme.iconTheme?.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return AnimatedTheme(
            duration: const Duration(milliseconds: 15000),
            data: state.themeData,
            child: ListView(
              children: [
                ListTile(
                  trailing: state.themeData == lightTheme
                      ? const Icon(
                          Icons.check,
                          color: Colors.yellow,
                        )
                      : const Icon(Icons.check),
                  title: Text(
                    'Светлая',
                    style: theme.textTheme.bodyMedium,
                  ),
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context).add(lightThemeEvent());
                  },
                ),
                ListTile(
                  trailing: state.themeData == darkTheme
                      ? const Icon(
                          Icons.check,
                          color: Colors.yellow,
                        )
                      : const Icon(Icons.check),
                  title: Text(
                    'Темная',
                    style: theme.textTheme.bodyMedium,
                  ),
                  onTap: () {
                    BlocProvider.of<ThemeBloc>(context).add(darkThemeEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
