import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_launches/bloc/launches_bloc.dart';
import 'package:spacex_launches/datasource/http_launches_datasource.dart';
import 'package:spacex_launches/models/launch.dart';
import 'package:spacex_launches/repository/launches_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final initialData = LaunchesRepository(HttpLaunchesDatasource());
  late LaunchesBloc launchesBloc;
  late List<Launch> launches = [];

  @override
  void initState() {
    super.initState();
    launchesBloc = LaunchesBloc(initialData);
    loadLaunches();
  }

  void loadLaunches() async {
    launches = await launchesBloc.getLaunches();
    launchesBloc.launchesStream.listen((launches) async {
      setState(() {
        this.launches = launches as List<Launch>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => launchesBloc.launchesStream,
      initialData: launchesBloc.getLaunches(),
      child: Scaffold(
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
          body: launches.isEmpty
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
                          leading: Image.asset('lib/assets/shuttle.png'),
                          // leading: Image.network(launches[index].links.missionPatch),
                        ),
                      ),
                    ),
                  ),
                )),
    );
  }
}
