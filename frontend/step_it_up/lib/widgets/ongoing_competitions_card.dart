import 'package:flutter/material.dart';
import 'package:step_it_up/models/competition_model.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:intl/intl.dart';

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
      color: Color.fromARGB(255, 184, 190, 221),
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
