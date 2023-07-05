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
          }
        } catch (e) {
          if (e is DioException && e.response != null) {
            final responseData = e.response!.data;
            if (responseData is Map<String, dynamic>) {
              final errorMessage = responseData['message'];
              logger.d(errorMessage);
              emit(RegisterFailed(errorMessage));
            } else if (responseData is String) {
              final errorMessage = responseData;
              logger.d(errorMessage);
              emit(RegisterFailed(errorMessage));
            } else {
              logger.d(
                  'Unexpected response data type: ${responseData.runtimeType}');
            }
          } else {
            logger.d(e.toString());
          }
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
