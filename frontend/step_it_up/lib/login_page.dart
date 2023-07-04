import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_it_up/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Material(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final loginBloc = BlocProvider.of<LoginBloc>(context);
            if (state is LoginInProgress) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
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
                  const Icon(Icons.image, size: 100),
                  const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(fontSize: 42),
                        ),
                        Text('Create your account')
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
                              decoration: const InputDecoration(
                                  hintText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: Colors.blueGrey,
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: TextFormField(
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
                              onPressed: () {},
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
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.image, size: 300),
                  const SizedBox(
                    width: 280,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Step It Up!',
                          style: TextStyle(fontSize: 60),
                        ),
                        Text('Show your friends who rules the streets')
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
            }
          },
        ),
      ),
    );
  }
}
