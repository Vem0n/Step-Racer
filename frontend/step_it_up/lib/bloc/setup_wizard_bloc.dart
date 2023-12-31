import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setup_wizard_event.dart';
part 'setup_wizard_state.dart';

class SetupWizardBloc extends Bloc<SetupWizardEvent, SetupWizardState> {
  String _selectedDevice = '';

  SetupWizardBloc() : super(SetupWizardInitial()) {
    on<SetupWizardEvent>((event, emit) {
      if (event is SetupWizardLoader) {
        emit(SetupWizardInProgress());
      } else if (event is DeviceSelected) {
        _selectedDevice = event.deviceName;
        emit(SetupWizardInProgress(selectedDevice: _selectedDevice));
      }
    });
  }
}
