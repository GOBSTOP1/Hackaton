part of 'menuBloc.dart';

class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState{}

class MenuLoaded extends MenuState{
  final List<Dish> dishList;

  MenuLoaded({required this.dishList});
}

class MenuLoadingFailure extends MenuState{}