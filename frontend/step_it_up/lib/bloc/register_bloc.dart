import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import '../login_page.dart';
import '../models/register_data.dart';
import 'package:step_it_up/fetcher.dart';
import 'package:dio/dio.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final fetcher = ApiFetcher();
  final logger = Logger();
  RegisterBloc() : super(RegisterInitial()) {
on<RegisterEvent>((event, emit) async {
    if (event is RegisterHandler) {
      emit(RegisterInProgress());
      try {
        final jsonData = jsonEncode(event.data.toJson());
        final response = await fetcher.post('http://10.0.2.2:8080/auth/signup', jsonData);
        debugPrint(response.toString());
        if (response.statusCode == 200) {
          debugPrint('Success');
        } else {
          debugPrint('Failure');
        }
      } catch (e) {
        if (e is DioException && e.response != null) {
          final errorMessage = e.response!.data['message'];
          logger.d(errorMessage);
          emit(RegisterFailed(errorMessage));
        } else {
          logger.d(e.toString());
        }
      }
      emit(RegisterInitial());
    } else if (event is RegisterRouter) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => LoginPage(),
          ),
        );
    }
  });
  }
}
