part of 'settings_menu_bloc.dart';

@immutable
sealed class SettingsMenuEvent {}

class SettingsLoader extends SettingsMenuEvent {
}

class SettingsReturn extends SettingsMenuEvent {
  final BuildContext context;

  SettingsReturn(this.context);
}

class SettingsLogout extends SettingsMenuEvent {
  final BuildContext context;

  SettingsLogout(this.context);
}