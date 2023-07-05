part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginLoading extends LoginState {}

class LoginCompleted extends LoginState {
    final int? statusCode;

  LoginCompleted(this.statusCode) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginCompleted && other.statusCode == statusCode;
  }

  @override
  int get hashCode => statusCode.hashCode;
}

class LoginFailed extends LoginState {}
