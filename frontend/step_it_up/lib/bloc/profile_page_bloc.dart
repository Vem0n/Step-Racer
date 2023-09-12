import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:step_it_up/settings_menu.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(ProfilePageInitial()) {
    on<ProfilePageEvent>((event, emit) {
      if (event is ProfilePageBack) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => SettingsMenu(),
          ),
        );
      }
    });
  }
}
