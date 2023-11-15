part  of 'orgBloc.dart';

class OrganisationState{}

class OrganisationInitial extends OrganisationState{}

class OrganisationLoading extends OrganisationState{}

class OrganisationLoaded extends OrganisationState{
  final List<Organisation> orgList;

  OrganisationLoaded({required this.orgList});
}

class OrganisationLoadingFailure extends OrganisationState{}
