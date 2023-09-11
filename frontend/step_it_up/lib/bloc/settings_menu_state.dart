part of 'settings_menu_bloc.dart';

@immutable
sealed class SettingsMenuState {}

final class SettingsMenuInitial extends SettingsMenuState {}

final class SettingsMenuNoDevice extends SettingsMenuState {}

final class SettingsMenuSetDevice extends SettingsMenuState {}
