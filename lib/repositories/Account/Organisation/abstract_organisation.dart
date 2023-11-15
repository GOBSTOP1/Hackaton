import 'package:hackaton2/repositories/Account/Organisation/models/models.dart';

abstract class AbstractOrganisationRepository {
  Future<List<Organisation>> loadOrganisations();
}