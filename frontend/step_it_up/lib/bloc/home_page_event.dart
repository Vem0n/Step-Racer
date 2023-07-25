part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class HomeLoader extends HomePageEvent {
}

class HomeSetupInitiator extends HomePageEvent {
  final BuildContext context;

  HomeSetupInitiator(this.context);
}