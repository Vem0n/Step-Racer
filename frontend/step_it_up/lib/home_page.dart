import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_page_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'models/competition_model.dart';
import 'models/group_competition_model.dart';
import 'widgets/ongoing_competitions_card.dart';
import 'widgets/ongoing_group_competitions_card.dart';

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
              return ZoomDrawer(
                menuScreen: const DrawerScreen(),
                mainScreen: MainScreen(),
                borderRadius: 30,
                showShadow: true,
                angle: 0.0,
                menuBackgroundColor: const Color.fromARGB(255, 156, 137, 184),
              );
            }
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<CompetitionCard> dummyData = [
    CompetitionCard(
        user1: 'Janet',
        user2: 'George',
        timer: DateTime.now(),
        score1: 0000,
        score2: 0000),
    CompetitionCard(
        user1: 'Jane',
        user2: 'Bob',
        timer: DateTime.now(),
        score1: 1200,
        score2: 800),
    CompetitionCard(
        user1: 'Xavier',
        user2: 'James',
        timer: DateTime.now(),
        score1: 3000,
        score2: 14000),
    CompetitionCard(
        user1: 'Dude',
        user2: 'Bro',
        timer: DateTime.now(),
        score1: 13,
        score2: 1),
  ];

  final List<GroupCompetitionCard> dummyData2 = [
    GroupCompetitionCard(
        user1: 'James',
        user2: 'Janet',
        user3: 'John',
        user4: 'George',
        user5: 'Damian',
        user6: 'Xavier',
        timer: DateTime.now(),
        score1: 100,
        score2: 300,
        score3: 400,
        score4: 12,
        score5: 11,
        score6: 10000),
    GroupCompetitionCard(
        user1: 'James',
        user2: 'Janet',
        timer: DateTime.now(),
        score1: 100,
        score2: 300),
    GroupCompetitionCard(
        user1: 'James',
        user2: 'Janet',
        user3: 'John',
        user4: 'George',
        timer: DateTime.now(),
        score1: 100,
        score2: 300,
        score3: 400,
        score4: 12),
    GroupCompetitionCard(
        user1: 'James',
        user2: 'Janet',
        user3: 'John',
        timer: DateTime.now(),
        score1: 100,
        score2: 300,
        score3: 400),
    GroupCompetitionCard(
        user1: 'James',
        user2: 'Janet',
        user3: 'John',
        user4: 'George',
        user5: 'Damian',
        timer: DateTime.now(),
        score1: 100,
        score2: 300,
        score3: 400,
        score4: 12,
        score5: 11)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const DrawerWdiget(),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: 250,
                height: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/app_logo.png'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              )
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 240, 230, 239),
          elevation: 0),
      backgroundColor: const Color.fromARGB(255, 240, 230, 239),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (dummyData.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: OngoingCompetitionsCard(competitions: dummyData),
                  ),
                if (dummyData2.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:
                        OngoingGroupCompetitionsCard(competitions: dummyData2),
                  ),
                if (dummyData.isEmpty && dummyData2.isEmpty)
                  const Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nothing here yet!',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ]),
                      Text('Compete with friends to start')
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: const Color.fromARGB(255, 184, 190, 221),
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/trophy_icon.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Your trophies will be right here!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Well, if you get any...",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 156, 137, 184),
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
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
    );
  }
}
