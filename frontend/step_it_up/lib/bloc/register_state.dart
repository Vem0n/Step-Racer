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

class RegisterSuccess extends RegisterState {
  final int? statusCode;

  RegisterSuccess(this.statusCode) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterSuccess && other.statusCode == statusCode;
  }

  @override
  int get hashCode => statusCode.hashCode;
}