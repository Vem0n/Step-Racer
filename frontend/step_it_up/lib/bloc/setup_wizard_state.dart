part of 'setup_wizard_bloc.dart';

@immutable
abstract class SetupWizardState {}

class SetupWizardInitial extends SetupWizardState {}

class SetupWizardInProgress extends SetupWizardState {}

class SetupWizardLoading extends SetupWizardState {}

class SetupWizardCompleted extends SetupWizardState {}

class SetupWizardFailed extends SetupWizardState {}
