import 'package:flutter/material.dart';
import 'package:step_it_up/models/competition_model.dart';

class CompHistory extends StatelessWidget {
  final List<WonCompetitionCard> competitions;

  CompHistory({required this.competitions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: const Color.fromARGB(255, 184, 190, 221),
      child: Container(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: competitions.map((competition) {
              return WonCompetitionCardView(
                wonCompetition: competition,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class WonCompetitionCardView extends StatelessWidget {
  final WonCompetitionCard wonCompetition;

  WonCompetitionCardView({required this.wonCompetition});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.4, color: Colors.lightBlue),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Won against ${wonCompetition.user2}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.stars,
                  size: 30,
                  color: Colors.yellow,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

