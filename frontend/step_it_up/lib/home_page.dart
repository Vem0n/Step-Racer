import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_page_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'models/competition_model.dart';
import 'models/group_competition_model.dart';
import 'package:intl/intl.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

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
                mainScreen: SingleChildScrollView(child: MainScreen()),
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
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DrawerWdiget(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Step It Up!',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 12,
              ),
              Icon(
                Icons.person,
                size: 30,
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OngoingCompetitionsCard(competitions: dummyData),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OngoingGroupCompetitionsCard(competitions: dummyData2),
              )
            ],
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

class OngoingCompetitionsCard extends StatefulWidget {
  final List<CompetitionCard> competitions;

  OngoingCompetitionsCard({required this.competitions});

  @override
  _OngoingCompetitionsCardState createState() =>
      _OngoingCompetitionsCardState();
}

class _OngoingCompetitionsCardState extends State<OngoingCompetitionsCard> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.blueGrey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.competitions.length,
              itemBuilder: (context, index) {
                final competition = widget.competitions[index];
                return CompetitionCardView(
                  competition: competition,
                );
              },
              onPageChanged: (index) {
                _currentPageNotifier.value = index;
              },
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, value, _) {
              return PageViewDotIndicator(
                currentItem: value,
                count: widget.competitions.length,
                unselectedColor: Colors.grey,
                selectedColor: Colors.blue,
                unselectedSize: const Size(8, 8),
              );
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class OngoingGroupCompetitionsCard extends StatefulWidget {
  final List<GroupCompetitionCard> competitions;

  OngoingGroupCompetitionsCard({required this.competitions});

  @override
  _OngoingGroupCompetitionsCardState createState() =>
      _OngoingGroupCompetitionsCardState();
}

class _OngoingGroupCompetitionsCardState
    extends State<OngoingGroupCompetitionsCard> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.blueGrey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.competitions.length,
              itemBuilder: (context, index) {
                final competition = widget.competitions[index];
                return GroupCompetitionCardView(
                  competition: competition,
                );
              },
              onPageChanged: (index) {
                _currentPageNotifier.value = index;
              },
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, value, _) {
              return PageViewDotIndicator(
                currentItem: value,
                count: widget.competitions.length,
                unselectedColor: Colors.grey,
                selectedColor: Colors.blue,
                unselectedSize: const Size(8, 8),
              );
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CompetitionCardView extends StatelessWidget {
  final CompetitionCard competition;
  final timerFormatter = DateFormat('HH:mm:ss');

  CompetitionCardView({required this.competition});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/default_profile_picture.jpg'),
                      fit: BoxFit.cover),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            Text(
              '${competition.user1} VS ${competition.user2}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/default_profile_picture.jpg'),
                      fit: BoxFit.cover),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0)),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Ends in: ${timerFormatter.format(competition.timer)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Your score: ${competition.score1}',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${competition.user2}'s score: ${competition.score2}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                debugPrint('Nice!');
              },
              icon: const Icon(
                Icons.refresh,
                size: 40,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class GroupCompetitionCardView extends StatelessWidget {
  final GroupCompetitionCard competition;
  final timerFormatter = DateFormat('HH:mm:ss');

  GroupCompetitionCardView({required this.competition});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/default_profile_picture.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Text(
                  competition.user1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('Score:'),
                Text('${competition.score1}'),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/default_profile_picture.jpg'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Text(
                  competition.user2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('Score:'),
                Text('${competition.score2}'),
              ],
            ),
            if (competition.user3 != null)
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/default_profile_picture.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Text(
                    competition.user3!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Score:'),
                  Text('${competition.score3}'),
                ],
              ),
            if (competition.user4 != null)
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/default_profile_picture.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Text(
                    competition.user4!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Score:'),
                  Text('${competition.score4}'),
                ],
              ),
            if (competition.user5 != null)
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/default_profile_picture.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Text(
                    competition.user5!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Score:'),
                  Text('${competition.score5}'),
                ],
              ),
            if (competition.user6 != null)
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/default_profile_picture.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Text(
                    competition.user6!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Score:'),
                  Text('${competition.score6}'),
                ],
              ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Ends in: ${timerFormatter.format(competition.timer)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                debugPrint('Nice!');
              },
              icon: const Icon(
                Icons.refresh,
                size: 40,
              ),
            ),
            SizedBox(
              width: 38,
            )
          ],
        )
      ],
    );
  }
}
