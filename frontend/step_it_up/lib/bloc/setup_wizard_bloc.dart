import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setup_wizard_event.dart';
part 'setup_wizard_state.dart';

class SetupWizardBloc extends Bloc<SetupWizardEvent, SetupWizardState> {
  SetupWizardBloc() : super(SetupWizardInitial()) {
    on<SetupWizardEvent>((event, emit) {
      if (event is SetupWizardLoader) {
        emit(SetupWizardInProgress());
      }
    });
  }
}
