import 'package:flutter/material.dart';

class TrophyCard extends StatelessWidget {
  const TrophyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
    );
  }
}
