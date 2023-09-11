import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/home_page.dart';

part 'settings_menu_event.dart';
part 'settings_menu_state.dart';

class SettingsMenuBloc extends Bloc<SettingsMenuEvent, SettingsMenuState> {
  SettingsMenuBloc() : super(SettingsMenuInitial()) {
    on<SettingsMenuEvent>((event, emit) {
      if (event is SettingsReturn) {
        Navigator.push(
              event.context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(),
              ),
            );
      }
    });
  }
}
