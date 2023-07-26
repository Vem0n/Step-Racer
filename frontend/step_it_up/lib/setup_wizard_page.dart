import 'package:flutter/material.dart';
import 'bloc/setup_wizard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/loading_screen.dart';

class SetupWizardPage extends StatelessWidget {
  const SetupWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupWizardBloc(),
      child: Material(
        child: BlocBuilder<SetupWizardBloc, SetupWizardState>(
          builder: (context, state) {
            final setupBloc = BlocProvider.of<SetupWizardBloc>(context);
            setupBloc.add(SetupWizardLoader());

            if (state is SetupWizardInitial) {
              return Container(
                color: Colors.white,
                child: LoadingAnimation(),
              );
            } else if (state is SetupWizardLoading) {
              return Container(
                color: Colors.white,
                child: LoadingAnimation(),
              );
            } else if (state is SetupWizardInProgress) {
              return Stepper(steps: [
                Step(
                    title: Text('Select your device'),
                    content: Text('do it now!'))
              ]);
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
