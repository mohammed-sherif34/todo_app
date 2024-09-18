part of 'config_cubit.dart';

//@immutable
sealed class ConfigState {}

final class ConfigInitial extends ConfigState {}

final class ConfigChangeLanguageState extends ConfigState {}

final class ConfigChangeThemeState extends ConfigState {}
