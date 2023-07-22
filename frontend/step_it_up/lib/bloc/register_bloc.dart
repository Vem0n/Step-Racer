import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';

import '../login_page.dart';
import '../models/register_data.dart';
import 'package:step_it_up/fetcher.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final fetcher = ApiFetcher();
  final logger = Logger();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterHandler) {
        try {
          emit(RegisterInProgress());
          final jsonData = jsonEncode(event.data.toJson());
          final response =
              await fetcher.put('http://10.0.2.2:8080/auth/signup', jsonData);
          debugPrint(response.toString());
          if (response.statusCode == 200) {
            final int? statusCode = response.statusCode;
            emit(RegisterSuccess(statusCode));
          } else {
            debugPrint('Failure');
            final responseData = response.data;
            if (responseData is Map<String, dynamic>) {
              if (responseData.containsKey('errors')) {
                final errors = responseData['errors'] as List<dynamic>;
                if (errors.isNotEmpty && errors.first is Map<String, dynamic>) {
                  final errorMessage = errors.first['msg'];
                  logger.d(errorMessage);
                  emit(RegisterFailed(errorMessage));
                  return;
                }
              }
            }
            emit(RegisterFailed('Something went wrong. Please try again later.'));
          }
        } catch (e) {
          debugPrint('Exception occurred: $e');
          emit(RegisterFailed('An unexpected error occurred. Please try again later.'));
        }
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
