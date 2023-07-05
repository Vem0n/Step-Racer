import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_page_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: Material(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            final homeBloc = BlocProvider.of<HomePageBloc>(context);
            homeBloc.add(HomeLoader());

            if (state is HomePageInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else {
              return const ZoomDrawer(
                menuScreen: DrawerScreen(),
                mainScreen: MainScreen(),
                borderRadius: 30,
                showShadow: true,
                angle: 0.0,
                menuBackgroundColor: Colors.blue,
              );
            }
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [DrawerWdiget()],
          )
        ],
      ),
    );
  }
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 40),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Contacts',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.add_circle,
                size: 42,
              )
            ]),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text('Friend'),
                  Icon(Icons.add),
                  Icon(Icons.cancel_outlined)
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget drawerList(IconData icon, String text) {
  return Container(
    margin: const EdgeInsets.only(left: 20),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 20,
        ),
        Text(text)
      ],
    ),
  );
}

class DrawerWdiget extends StatelessWidget {
  const DrawerWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: const Icon(Icons.menu),
    );
  }
}
