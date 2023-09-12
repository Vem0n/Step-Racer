part of 'profile_page_bloc.dart';

@immutable
sealed class ProfilePageEvent {}

class ProfilePageBack extends ProfilePageEvent {
  final BuildContext context;

  ProfilePageBack(this.context);
}