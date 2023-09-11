part of 'settings_menu_bloc.dart';

@immutable
sealed class SettingsMenuEvent {}

class SettingsReturn extends SettingsMenuEvent {
  final BuildContext context;

  SettingsReturn(this.context);
}