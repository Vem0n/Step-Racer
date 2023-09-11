import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_it_up/login_page.dart';

part 'settings_menu_event.dart';
part 'settings_menu_state.dart';

class SettingsMenuBloc extends Bloc<SettingsMenuEvent, SettingsMenuState> {
  SettingsMenuBloc() : super(SettingsMenuInitial()) {
    on<SettingsMenuEvent>((event, emit) async {
      if (event is SettingsReturn) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => HomePage(),
          ),
        );
      } else if (event is SettingsLoader) {
        final prefs = await SharedPreferences.getInstance();
        final String? device = prefs.getString('device');
        if (device == null) {
          emit(SettingsMenuNoDevice());
        } else {
          emit(SettingsMenuSetDevice());
        }
      } else if (event is SettingsLogout) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
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
