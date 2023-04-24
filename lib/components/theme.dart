import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  bool isDarkTheme = false;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    emit(isDarkTheme as ThemeMode);
  }

}