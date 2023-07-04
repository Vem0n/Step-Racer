import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey, width: 4),
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
            const SizedBox(
              height: 95,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 42),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Create your account')
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
                            // Perform registration logic
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
      ),
    );
  }
}
