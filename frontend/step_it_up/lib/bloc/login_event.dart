part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginChoiceSelected extends LoginEvent {}

class LoginPrevious extends LoginEvent {}

class SignUpChoiceSelected extends LoginEvent {
  final BuildContext context;

  SignUpChoiceSelected(this.context);
}