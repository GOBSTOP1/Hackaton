import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/themeData/theme.dart';

// import 'package:talker_flutter/talker_flutter.dart';
import 'routes/routes.dart';
import 'themeData/bloc/themebloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state)  {
          return MaterialApp(
            
            theme: state.themeData,
            routes: routes,
            navigatorObservers: [
              // TalkerRouteObserver(GetIt.I<Talker>()),
            ],
            initialRoute: '/firebaseStreem',
          );
        },
      ),
    );
  }
}
