part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterInProgress extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String errorMessage;

  RegisterFailed(this.errorMessage);

  List<Object?> get props => [errorMessage];
}