import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/features/Account/view/Organisation/bloc/orgBloc.dart';
import 'package:hackaton2/repositories/Account/Organisation/abstract_organisation.dart';
import 'package:hackaton2/services/SnackBar.dart';
import '../../../../repositories/Account/Organisation/models/models.dart';

class OrganisationScreen extends StatefulWidget {
  const OrganisationScreen({super.key});

  @override
  State<OrganisationScreen> createState() => _OrganisationState();
}

class _OrganisationState extends State<OrganisationScreen> {
  TextEditingController _searchOrgController = TextEditingController();
  final _orgBloc = OrganisationBloc(GetIt.I<AbstractOrganisationRepository>());
  List<Organisation> filteredOrgList = [];

  @override
  void initState() {
    _orgBloc.add(LoadOrganisationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Выбрать организацию',
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.appBarTheme.iconTheme?.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<OrganisationBloc, OrganisationState>(
        bloc: _orgBloc,
        builder: (context, state) {
          if (state is OrganisationLoaded) {
            filteredOrgList = state.orgList
                .where((org) =>
                    org.name.toLowerCase().contains(_searchOrgController.text.toLowerCase()))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchOrgController,
                    decoration: InputDecoration(
                      hintText: 'Найти организацию',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      print("Пользователь ищет: $value");
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrgList.length,
                    itemBuilder: (context, index) {
                      final org = filteredOrgList[index];
                      return ListTile(
                        leading: Image.network(org.logo),
                        title: Text(
                          org.name,
                          style: theme.textTheme.bodyMedium,
                        ),
                        onTap: () {
                          final userUid =
                              FirebaseAuth.instance.currentUser?.uid;
                          final usersCollection = FirebaseFirestore.instance
                              .collection('users');
                          usersCollection.doc(userUid).set({
                            'foodprovider_id': org.id,
                            'foodprovider_name': org.name,
                          }).then((_) {
                            print(
                                'Информация о выбранной организации записана в Firestore');
                          }).catchError((error) {
                            print('Ошибка записи в Firestore: $error');
                          });
                          print('Выбрана организация: ${org.name}');
                          SnackBarService.showSnackBar(context, 'Выбрана организация: ${org.name}', false);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
