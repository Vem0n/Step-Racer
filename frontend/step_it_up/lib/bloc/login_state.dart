part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCompleted extends LoginState {}

class LoginFailed extends LoginState {}
