part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterHandler extends RegisterEvent {
    final RegisterData data;

  RegisterHandler(this.data);

  List<Object> get props => [data];
}

class RegisterRouter extends RegisterEvent {
  final BuildContext context;

  RegisterRouter(this.context);
}
