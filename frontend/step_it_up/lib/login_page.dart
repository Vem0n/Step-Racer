import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_it_up/bloc/login_bloc.dart';
import 'package:step_it_up/models/login_data.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Material(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final loginBloc = BlocProvider.of<LoginBloc>(context);
            loginBloc.add(LoginValidator(context));

            void loginHandler() {
              final receivedUsername = email.text;
              final receivedPassword = password.text.toString();

              if (receivedPassword.isEmpty || receivedUsername.isEmpty) {
                debugPrint('Enter both cridentials');
                return;
              }

              final loginData = LoginData(
                  email: receivedUsername, password: receivedPassword);
              loginBloc.add(LoginInitiated(loginData));
              if (state is LoginCompleted) {
                loginBloc.add(LoginComplete(context));
              }
              email.text = '';
              password.text = '';
            }

            if (state is LoginInProgress || state is LoginFailed) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                              loginBloc.add(LoginPrevious());
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
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/app_icon.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(fontSize: 42),
                        ),
                        Text(
                          (state is LoginFailed)
                              ? 'Wrong credentials'
                              : 'Log into your account',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    width: 360,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              controller: email,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                              obscureText: true,
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
                        const SizedBox(height: 60),
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
                                loginHandler();
                              },
                              child: const Text('Login'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (state is LoginInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/app_icon.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/login_header.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Text('Show your friends who rules the streets')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 8,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                loginBloc.add(LoginChoiceSelected());
                              },
                              child: const Text('Login'),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                loginBloc.add(SignUpChoiceSelected(context));
                              },
                              child: const Text('Register'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
