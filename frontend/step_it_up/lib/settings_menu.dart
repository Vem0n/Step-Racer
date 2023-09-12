import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/settings_menu_bloc.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsMenuBloc(),
      child: Material(
        child: BlocBuilder<SettingsMenuBloc, SettingsMenuState>(
            builder: (context, state) {
          final settingsBloc = BlocProvider.of<SettingsMenuBloc>(context);
          settingsBloc.add(SettingsLoader());

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            settingsBloc.add(SettingsReturn(context));
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 40,
                          color: Colors.lightBlue,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.blue,
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            settingsBloc.add(SettingsProfile(context));
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'View your profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.lightBlue),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 570,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0, right: 20, left: 20),
                        child: Container(
                          width: 260,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.4, color: Colors.lightBlue),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is SettingsMenuNoDevice)
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 20,),
                                const Text(
                                  'Change Device',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0, right: 20, left: 20),
                        child: Container(
                          width: 260,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.4, color: Colors.lightBlue),
                            ),
                          ),
                          child: TextButton(
                              onPressed: () {
                                settingsBloc.add(SettingsLogout(context));
                              },
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0, right: 20, left: 20),
                        child: Container(
                          width: 260,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.4, color: Colors.lightBlue),
                            ),
                          ),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Delete Account',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
