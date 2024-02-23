import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/cubits/auth_cubit.dart';
import 'package:location/cubits/auth_state.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/services/location_service.dart';
import 'package:location/views/login_page.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';
import 'package:intl/intl.dart';

import '../models/location.dart';
import '../share/location_text_style.dart';

class LocationList extends StatefulWidget {
  static const String routeName = "/locations";

  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  final LocationService locationService = LocationService();
  late Future<List<Location>> _locations;

  @override
  void initState() {
    super.initState();
    _locations = locationService.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes locations",
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder<List<Location>>(
                future: _locations,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Location>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          _buildRow(snapshot.data![index], context),
                      itemCount: snapshot.data!.length,
                      itemExtent: 170,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          } else if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthInitial) {
            return Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => LoginPage('/home', false),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

_buildRow(Location location, BuildContext context) {
  return Container(
      child: Column(
    children: [
      _buildHabitat(location),
      _buildDates(location),
      _buildFacture(location),
      const Divider(
        height: 10,
        thickness: 1.5,
      )
    ],
  ));
}

_buildHabitat(Location location) {
  var format = NumberFormat("### €");
  var habitation = HabitationService().getHabitationById(location.id);
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: ListTile(
          title: Text(habitation.libelle),
          subtitle: Text(habitation.adresse),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          format.format(500.00),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
            fontSize: 22,
          ),
        ),
      ),
    ],
  );
}

_buildDates(Location location) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const Icon(Icons.date_range_outlined),
          Text(
            DateFormat.yMMMd("fr_FR").format(location.dateDebut),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
      const CircleAvatar(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      Row(
        children: [
          const Icon(Icons.date_range_outlined),
          Text(
            DateFormat.yMMMd("fr_FR").format(location.dateFin),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
    ],
  );
}

_buildFacture(Location location) {
  return Row(
    children: [
      const SizedBox(
        height: 40,
      ),
      location.facture != null
          ? Text(
              "Facture délivrée le ${DateFormat.yMMMd("fr_FR").format(location.facture!.date)}.")
          : const Text("Impossible de fournir la date.")
    ],
  );
}
