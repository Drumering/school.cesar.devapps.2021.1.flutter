import 'package:flutter/material.dart';
import 'package:spacex_launches/bloc/launches/launch_bloc.dart';
import 'package:spacex_launches/bloc/launches/launch_state.dart';

import '../bloc/launches/launch_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LaunchesBloc launchesBloc;

  bool isSelectected = false;

  @override
  void initState() {
    super.initState();
    launchesBloc = LaunchesBloc();
    launchesBloc.eventSink.add(LoadLaunchesEvent(context: context));
  }

  @override
  void dispose() {
    super.dispose();
    launchesBloc.eventSink.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LaunchState>(
        stream: launchesBloc.stateStream,
        builder: (context, AsyncSnapshot<LaunchState> snapshot) {
          final launches = snapshot.data?.launches ?? [];
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Image.asset(
                  'lib/assets/spacex_logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Column(
                children: [
                  FilterChip(
                    label: const Text("Successfully Launches"),
                    selected: isSelectected,
                    selectedColor: Colors.greenAccent,
                    onSelected: (bool value) {
                      setState(() {
                        isSelectected = value;
                        launchesBloc.eventSink.add(FilterLaunchesBySuccessEvent(
                            success: value, context: context));
                        //Ajustar para desfazer filtro por sucesso
                      });
                    },
                  ),
                  Expanded(
                    child: launches.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ListView.builder(
                                itemCount: launches.length,
                                itemBuilder: (ctx, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(launches[index].missionName),
                                    subtitle: Text(launches[index].details),
                                    leading:
                                        Image.asset('lib/assets/shuttle.png'),
                                    // leading: Image.network(launches[index].links.missionPatch),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ));
        });
  }
}
