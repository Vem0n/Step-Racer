import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/models/login_data.dart';
import 'package:step_it_up/register_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:step_it_up/home_page.dart';
import 'package:step_it_up/fetcher.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          final response =
              await fetcher.post('http://10.0.2.2:8080/auth/login', jsonData);
          final prefs = await SharedPreferences.getInstance();
          final token = response.data['token'];
          prefs.setString('token', token.toString());
          debugPrint(response.toString());
          if (response.statusCode == 200) {
            debugPrint('Success');
            final int? statusCode = response.statusCode;
            emit(LoginCompleted(statusCode));
          } else if (response.statusCode != 200) {
            emit(LoginFailed());
            debugPrint('Failure');
          }
        } catch (e) {
          logger.d(e);
        }
      } else if (event is LoginComplete) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => HomePage(),
          ),
        );
      } else if (event is LoginValidator) {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token');
        if (token == null) {
          emit(LoginValidated());
          return;
        }

        try {
          if (JwtDecoder.isExpired(token)) {
            prefs.remove('token');
            emit(LoginValidated());
          } else if (!JwtDecoder.isExpired(token)) {
            Navigator.push(
              event.context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(),
              ),
            );
          }
        } catch (e) {
          logger.e('Something went wrong');
        }
      }
    });
  }
}
