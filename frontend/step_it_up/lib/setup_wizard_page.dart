import 'package:flutter/material.dart';
import 'widgets/loading_screen.dart';

class SetupWizardPage extends StatelessWidget {
  const SetupWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: LoadingAnimation(),);
  }
}