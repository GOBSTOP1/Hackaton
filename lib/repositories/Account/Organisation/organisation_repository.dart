import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackaton2/repositories/Account/Organisation/models/models.dart';

import 'abstract_organisation.dart';

class OrganisationRepository  implements AbstractOrganisationRepository{
  @override
  Future<List<Organisation>> loadOrganisations() async{
    try{
      final db = FirebaseFirestore.instance;
      final response = await db.collection('foodprovider').get();
      List<Organisation> orgList = response.docs.map((doc){
        Map<String, dynamic> data = doc.data();
        return Organisation(id: doc.id, logo: data['logo_path'], name: data['name']);
      }).toList();
      for(var organisation in orgList){
        print('${organisation.id} ${organisation.logo} ${organisation.name}');
      }
      return orgList;
    } catch (e){
      print('Ошибка: $e');
      return [];
    }
  }
}