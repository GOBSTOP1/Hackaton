// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hackaton2/themeData/bloc/themebloc.dart';
// // import 'package:talker_flutter/talker_flutter.dart';

// class DrawerBloc extends StatelessWidget {
//   const DrawerBloc({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeBloc(),
//       child: Theme(
//         data: Theme.of(context),
//         child: Drawer(
//           child: Container(
//             child: ListView(
//               children: <Widget>[
//                 DrawerHeader(
//                   child: Text(
//                     "Ваш заголовок вверху",
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                 ),
//                 ListTile(
//                   title: Text(
//                     "Меню 1",
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   trailing: Icon(Icons.arrow_back),
//                 ),
//                 ListTile(
//                   title: Text(
//                     "Меню 2",
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   trailing: Icon(Icons.arrow_downward),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     onPressed: () {
//                       BlocProvider.of<ThemeBloc>(context)
//                           .add(darkThemeEvent());
//                     },
//                     child: Text(
//                       "Темная тема",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     onPressed: () {
//                       BlocProvider.of<ThemeBloc>(context)
//                           .add(lightThemeEvent());
//                     },
//                     child: Text(
//                       "Белая тема",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text('Логи',style: Theme.of(context).textTheme.titleLarge,),
//                   leading: IconButton(onPressed: (){}, 
//                   icon: Icon(Icons.document_scanner_outlined)),
//                   // onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => TalkerScreen(talker: GetIt.I<Talker>(),)),);},
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
