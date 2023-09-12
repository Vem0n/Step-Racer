import 'package:flutter/material.dart';
import 'package:step_it_up/models/trophy_model.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class TrophyList extends StatefulWidget {
  final List<Trophy> trophies;

  TrophyList({required this.trophies});

  @override
  _TrophyListState createState() => _TrophyListState();
}

class _TrophyListState extends State<TrophyList> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: const Color.fromARGB(255, 184, 190, 221),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 110,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.trophies.length,
              itemBuilder: (context, index) {
                final trophy = widget.trophies[index];
                return TrophyCardView(
                  trophy: trophy,
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
                count: widget.trophies.length,
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

class TrophyCardView extends StatelessWidget {
  final Trophy trophy;

  TrophyCardView({required this.trophy});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12,),
        const Icon(
          Icons.star,
          size: 50,
          color: Colors.yellow,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          trophy.trophyName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
