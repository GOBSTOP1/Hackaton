import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hackaton2/themeData/theme.dart';


part 'themeStatebloc.dart';
part 'themEventbloc.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(lightTheme)) {
    on<darkThemeEvent>(_onSetDarkTheme);
    on<lightThemeEvent>(_onSetLightTheme);
  }

  _onSetDarkTheme(darkThemeEvent event, Emitter<ThemeState> emit) {
    print('Switching to Dark Theme1');
    emit(ThemeState(darkTheme));
  }

  _onSetLightTheme(lightThemeEvent event, Emitter<ThemeState> emit) {
    print('Switching to Light Theme2');
    emit(ThemeState(lightTheme));
  }
}