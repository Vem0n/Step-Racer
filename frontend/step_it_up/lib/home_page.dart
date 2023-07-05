import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_page_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: Material(
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            final homeBloc = BlocProvider.of<HomePageBloc>(context);
            homeBloc.add(HomeLoader());

            if (state is HomePageInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Drawer(),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Card(
                            color: Colors.grey,
                            elevation: 22,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
