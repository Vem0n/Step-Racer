import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationTransition(
      animation: _animationController,
    );
  }
}

class LoadingAnimationTransition extends AnimatedWidget {
  LoadingAnimationTransition({required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animationValue = listenable as Animation<double>;

    return Center(
      child: Container(
        width:
            100.0 + (animationValue.value * 20.0), // Adjust the size as needed
        height: 100.0 + (animationValue.value * 20.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
                'assets/app_icon.png'), // Replace with your loading image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
