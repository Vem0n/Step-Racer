part of 'setup_wizard_bloc.dart';

@immutable
abstract class SetupWizardState {}

class SetupWizardInitial extends SetupWizardState {}

class SetupWizardInProgress extends SetupWizardState {
  final String? selectedDevice;

  SetupWizardInProgress({this.selectedDevice});
}

class SetupWizardLoading extends SetupWizardState {}

class SetupWizardCompleted extends SetupWizardState {}

class SetupWizardFailed extends SetupWizardState {}
