import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackaton2/repositories/Account/Organisation/abstract_organisation.dart';
import 'package:hackaton2/repositories/Account/Organisation/models/models.dart';

part 'orgEvent.dart';
part 'orgState.dart';

class OrganisationBloc extends Bloc<OrganisationEvent, OrganisationState> {
  OrganisationBloc(this.organisationRepository) : super(OrganisationInitial()) {
    on<LoadOrganisationsEvent>((event, emit) async {
      final orgList = await organisationRepository.loadOrganisations();
      emit(OrganisationLoaded(orgList: orgList));
      
    });
  }
  final AbstractOrganisationRepository organisationRepository;
}
