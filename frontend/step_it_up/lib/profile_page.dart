import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_it_up/widgets/trpohy_list.dart';
import 'bloc/profile_page_bloc.dart';
import 'models/trophy_model.dart';
import 'models/competition_model.dart';
import 'widgets/competition_history_card.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<Trophy> trophies = [
    Trophy(trophyName: 'Wyciąganie chuja z wody', trophyIcon: 'placeholder'),
    Trophy(trophyIcon: 'placeholder', trophyName: 'Otwarcie parasola'),
    Trophy(trophyIcon: 'placeholder', trophyName: 'Kładzenie chuja na tacę')
  ];

  final List<WonCompetitionCard> competitions = [
    WonCompetitionCard(user1: 'Luigi Pasta', user2: 'Mario Meatball'),
    WonCompetitionCard(user1: 'Gina Gnocchi', user2: 'Tony Tortellini'),
    WonCompetitionCard(user1: 'Sofia Spaghetti', user2: 'Vinny Vermicelli'),
    WonCompetitionCard(user1: 'Rocco Ravioli', user2: 'Lina Lasagna'),
    WonCompetitionCard(user1: 'Vito Veggies', user2: 'Nina Noodles'),
    WonCompetitionCard(user1: 'Sal Pesto', user2: 'Angelina Alfredo'),
    WonCompetitionCard(user1: 'Enzo Espresso', user2: 'Bella Biscotti'),
    WonCompetitionCard(user1: 'Antonio Antipasto', user2: 'Isabella Risotto'),
    WonCompetitionCard(user1: 'Giorgio Gelato', user2: 'Rosa Risotto'),
    WonCompetitionCard(user1: 'Mario Mozzarella', user2: 'Giovanna Gorgonzola'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageBloc(),
      child: Material(
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
            builder: (context, state) {
          final pageBloc = BlocProvider.of<ProfilePageBloc>(context);

          if (state is ProfilePageInitial) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            pageBloc.add(ProfilePageBack(context));
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                          iconSize: 30,
                          color: Colors.blue,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
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
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Description',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: TrophyList(trophies: trophies),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: CompHistory(competitions: competitions),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Win streak:',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
