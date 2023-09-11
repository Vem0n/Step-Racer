part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomeLoader extends HomePageEvent {
}

class HomeSetupInitiator extends HomePageEvent {
  final BuildContext context;

  HomeSetupInitiator(this.context);
}

class HomeSettingsInitiator extends HomePageEvent {
  final BuildContext context;

  HomeSettingsInitiator(this.context);
}