import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hackaton2/repositories/Menu/abstract_menu.dart';

import '../../../repositories/Menu/menu.dart';
part 'menuEvent.dart';
part 'menuState.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this.menuRepository) : super(MenuInitial()) {
    on<LoadMenuEvent>((event, emit) async {
      final dishList = await menuRepository.loadMenu();
      emit(MenuLoaded(dishList: dishList));
    });
  }

  final AbstractMenuRepository menuRepository;
}
