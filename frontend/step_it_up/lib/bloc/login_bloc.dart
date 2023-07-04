import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/register_page.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      if (event is LoginChoiceSelected) {
        emit(LoginInProgress());
      } else if (event is SignUpChoiceSelected) {
        emit(LoginInitial());
        Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                const RegisterPage(),
          ),
        );
      } else if (event is LoginPrevious) {
        emit(LoginInitial());
      }
    });
  }
}
