import 'package:flutter/material.dart';
import 'bloc/setup_wizard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/device_model.dart';
import 'widgets/loading_screen.dart';

class SetupWizardPage extends StatefulWidget {
  SetupWizardPage({super.key});

  @override
  State<SetupWizardPage> createState() => _SetupWizardPageState();
}

class _SetupWizardPageState extends State<SetupWizardPage> {
  final List<Device> devices = [
    Device(name: 'Fitbit Device', image: 'assets/fitbit_device.png'),
    Device(name: 'Garmin Device', image: 'assets/garmin_device.png'),
    Device(name: 'Mi Device', image: 'assets/mi_device.png'),
    Device(name: 'Samsung Device', image: 'assets/samsung_device.png'),
    Device(name: 'Google Device', image: 'assets/google_device.png'),
  ];

  String? selectedDeviceName;
  int currentStep = 0; // Store the current step index

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
              List<Widget> deviceCards = devices.map((device) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDeviceName = device.name;
                    });
                    setupBloc.add(DeviceSelected(device.name));
                  },
                  child: Card(
                    color: selectedDeviceName == device.name
                        ? Colors.blue
                        : Colors.white,
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(device.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(device.name),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList();

              return Stepper(
                currentStep: currentStep, // Set the current step index
                controlsBuilder: (context, _) {
                  // Show the "Confirm" button only in the first step
                  if (currentStep == 0 && selectedDeviceName != null) {
                    return Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  currentStep++;
                                });
                              },
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
                steps: [
                  Step(
                    title: Text('Select your device'),
                    content: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            ...deviceCards,
                          ],
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                  Step(title: Text('You are stinky'), content: Text('Take')),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
