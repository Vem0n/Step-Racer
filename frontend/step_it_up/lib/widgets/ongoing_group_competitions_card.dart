import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:step_it_up/models/group_competition_model.dart';
import 'package:intl/intl.dart';

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
      color: Color.fromARGB(255, 184, 190, 221),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text('Score:'),
                  Text('${competition.score6}'),
                ],
              ),
          ],
        ),
        const SizedBox(
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
            const SizedBox(
              width: 38,
            )
          ],
        )
      ],
    );
  }
}
