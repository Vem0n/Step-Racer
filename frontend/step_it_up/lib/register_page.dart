import 'package:flutter/material.dart';
import 'package:step_it_up/widgets/loading_screen.dart';

import 'bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/register_data.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Material(
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            final registerBloc = BlocProvider.of<RegisterBloc>(context);
            void registerHandler() {
              final receivedEmail = email.text.toString();
              final receivedPassword = password.text.toString();
              final receivedName = name.text.toString();
              final confirmedPassword = confirmPassword.text.toString();

              if (receivedPassword.isEmpty || receivedEmail.isEmpty || receivedName.isEmpty) {
                debugPrint('Enter both cridentials');
                return;
              }

              if (receivedPassword != confirmedPassword || confirmedPassword.isEmpty ) {
                debugPrint("Passwords don't match");
                return;
              }

              final registerData = RegisterData(
                  name: receivedName,
                  email: receivedEmail,
                  password: receivedPassword);
              registerBloc.add(RegisterHandler(registerData));
              email.text = '';
              password.text = '';
              name.text = '';
              confirmPassword.text = '';
              if (state is RegisterSuccess) {
                registerBloc.add(RegisterRouter(context));
              }
            }

            if (state is RegisterInProgress) {
              return LoadingAnimation();
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 4),
                                borderRadius: BorderRadius.circular(38)),
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 95,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(fontSize: 42),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            state is RegisterFailed
                                ? 'Registering failed, ${state.errorMessage}'
                                : 'Create your account',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              color: Colors.blueGrey,
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: name,
                                  decoration: const InputDecoration(
                                      hintText: 'Username',
                                      prefixIcon: Icon(Icons.person),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10)),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              color: Colors.blueGrey,
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                      hintText: 'Email Address',
                                      prefixIcon: Icon(Icons.email),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10)),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              color: Colors.blueGrey,
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: password,
                                  decoration: const InputDecoration(
                                      hintText: 'Password',
                                      prefixIcon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10)),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              color: Colors.blueGrey,
                              child: SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: confirmPassword,
                                  decoration: const InputDecoration(
                                      hintText: 'Confirm Password',
                                      prefixIcon: Icon(Icons.check_circle),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                              width: 270,
                              child: Text(
                                  'By registering you are agreeing to your data being handled by the creator of this app'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Card(
                              elevation: 20,
                              color: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(38)),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    registerHandler();
                                  },
                                  child: const Text('Register'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 90,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
