import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/models/login_data.dart';
import 'package:step_it_up/register_page.dart';
import 'package:step_it_up/fetcher.dart';
import 'package:logger/logger.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final fetcher = ApiFetcher();
  final logger = Logger();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginChoiceSelected) {
        emit(LoginInProgress());
      } else if (event is SignUpChoiceSelected) {
        emit(LoginInitial());
        Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => RegisterPage(),
          ),
        );
      } else if (event is LoginPrevious) {
        emit(LoginInitial());
      } else if (event is LoginInitiated) {
        emit(LoginLoading());
        try {
          final jsonData = jsonEncode(event.data.toJson());
          final response = await fetcher.post('http://10.0.2.2:8080/auth/login', jsonData);
          debugPrint(response.toString());
          if(response.statusCode == 200) {
            debugPrint('Success');
          } else if (response.statusCode != 200) {
            debugPrint('Failure');
          }
        } catch (e) {
          logger.d(e);
        }
        emit(LoginInProgress());
      }
    });
  }
}
