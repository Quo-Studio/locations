import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:location/models/habitation.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/habitation_details.dart';
import 'package:location/views/habitation_list.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';

class MyHomePage extends StatelessWidget {
  static const String routeName = "/home";
  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;

  MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key) {
    _typehabitats = service.getTypeHabitats();
    _habitations = service.getHabitationsTop10();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(context),
            SizedBox(height: 20),
            _buildDerniereLocation(context),
          ],
        ),
      ),
    );
  }

  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_typehabitats.length,
            (index) => _buildHabitat(context, _typehabitats[index])),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      case 1:
        icon = Icons.house;
        break;
      case 2:
        icon = Icons.apartment;
        break;
    }

    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HabitationList(typeHabitat.id == 1),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white70,
              ),
              SizedBox(width: 5),
              Text(
                typeHabitat.libelle,
                style: LocationTextStyle.regularWhiteTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        itemCount: _habitations.length,
        itemExtent: 220,
        itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HabitationDetails(habitation)),
        );
      },
      child: Container(
        width: 240,
        margin: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/images/locations/${habitation.image}',
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              habitation.libelle,
              style: LocationTextStyle.regularTextStyle,
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  habitation.adresse,
                  style: LocationTextStyle.boldTextStyle,
                ),
              ],
            ),
            Text(
              format.format(habitation.prixmois),
              style: LocationTextStyle.boldTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
