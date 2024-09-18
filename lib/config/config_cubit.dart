import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit() : super(ConfigInitial());
  static String language = 'en';
  static ThemeMode themeMode = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    if (language == newLanguage) return;
    language = newLanguage;

    emit(ConfigChangeLanguageState());
  }

  void changeTheme(ThemeMode newTheme) {
    if (themeMode == newTheme) return;
    themeMode = newTheme;

    emit(ConfigChangeThemeState());
  }

  static bool isDark() {
   return themeMode == ThemeMode.dark;
  }
}
