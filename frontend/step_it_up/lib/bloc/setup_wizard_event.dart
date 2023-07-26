part of 'setup_wizard_bloc.dart';

@immutable
abstract class SetupWizardEvent {}

class SetupWizardLoader extends SetupWizardEvent {}

class DeviceSelected extends SetupWizardEvent {
  final String deviceName;

  DeviceSelected(this.deviceName);
}
