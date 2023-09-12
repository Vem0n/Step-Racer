import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_it_up/widgets/loading_screen.dart';
import 'bloc/home_page_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'models/competition_model.dart';
import 'models/group_competition_model.dart';
import 'models/friend_model.dart';
import 'widgets/ongoing_competitions_card.dart';
import 'widgets/ongoing_group_competitions_card.dart';
import 'widgets/trophy_card.dart';
import 'widgets/friend_tiles.dart';

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
              return LoadingAnimation();
            } else {
              return ZoomDrawer(
                menuScreen: DrawerScreen(),
                mainScreen: MainScreen(),
                borderRadius: 30,
                showShadow: true,
                angle: 0.0,
                menuBackgroundColor: const Color.fromARGB(255, 216, 206, 216),
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
    /*
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
  */
  ];

  final List<GroupCompetitionCard> dummyData2 = [
    /*
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
  */
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
              SettingsWidget()
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 240, 230, 239),
          elevation: 0),
      backgroundColor: const Color.fromARGB(255, 240, 230, 239),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final homeBloc = BlocProvider.of<HomePageBloc>(context);

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state is HomePageLoadedNoDevice)
                  GestureDetector(
                    onTap: () => homeBloc.add(HomeSetupInitiator(context)),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      color: const Color.fromARGB(255, 240, 230, 239),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 70,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/warning_icon.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Flexible(
                            child: Column(
                              children: [
                                Text(
                                  'Hey!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                                Text(
                                  "Let's start by connecting your device",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Press me whenever you feel like it",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                        child: OngoingGroupCompetitionsCard(
                            competitions: dummyData2),
                      ),
                    if (dummyData.isEmpty && dummyData2.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: const Color.fromARGB(255, 184, 190, 221),
                          child: const Column(
                            children: [
                              SizedBox(height: 40),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Nothing here yet!',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              SizedBox(height: 12),
                              Text('Compete with friends to start'),
                              SizedBox(height: 40)
                            ],
                          ),
                        ),
                      ),
                    const TrophyCard()
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});

  final List<Friend> friendData = [
    Friend(name: 'Jane', email: 'defined@gmail.com', status: 'active'),
    Friend(name: 'James', email: 'defined@gmail.com', status: 'active'),
    Friend(name: 'Janet', email: 'defined@gmail.com', status: 'pending'),
    Friend(name: 'George', email: 'defined@gmail.com', status: 'pending'),
    Friend(name: 'Xavier', email: 'defined@gmail.com', status: 'active'),
    Friend(
        name: 'HulkHoganBrother', email: 'defined@gmail.com', status: 'pending')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 206, 216),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Contacts',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: IconButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: TextField(
            // Add a controller to retrieve the input.
            controller: TextEditingController(),
            // Optionally, you can customize the TextField further.
            decoration: InputDecoration(
              hintText: 'Enter your text...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // Do something with the input value.
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
          ],
        );
      },
    );
  },
  icon: const Icon(
    Icons.add_circle,
    size: 42,
  ),
)

                )
              ]),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final friend = friendData[index];
                    if (friend.status == 'active') {
                      return ActiveFriendTile(friend: friend);
                    }
                    return Container();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Friend Requests',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: friendData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final friend = friendData[index];
                    if (friend.status == 'pending') {
                      return PendingFriendTile(friend: friend);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
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

class SettingsWidget extends StatelessWidget {
  SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child:
          BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
        final homeBloc = BlocProvider.of<HomePageBloc>(context);

        return IconButton(
          onPressed: () {
            homeBloc.add(HomeSettingsInitiator(context));
          },
          icon: const Icon(Icons.person),
          iconSize: 30,
          color: Colors.black,
        );
      }),
    );
  }
}
