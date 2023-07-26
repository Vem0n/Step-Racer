import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_it_up/setup_wizard_page.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) async {
      if (event is HomeLoader) {
        final prefs = await SharedPreferences.getInstance();
        final String? device = prefs.getString('device');
        if (device == null) {
          emit(HomePageLoadedNoDevice());
        } else {
          emit(HomePageLoadedSetDevice());
        }
      } else if (event is HomeSetupInitiator) {
        Navigator.push(
              event.context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => SetupWizardPage(),
              ),
            );
      }
    });
  }
}
