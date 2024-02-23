import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/resa_location.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';
import 'package:location/views/share/habitation_features_widget.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  late Habitation _habitation;
  @override
  initState() {
    super.initState();
    _habitation = widget._habitation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(0),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.libelle),
                Text(widget._habitation.adresse),
              ],
            ),
          ),
          HabitationFeaturesWidget(widget._habitation),
          SizedBox(height: 15),
          _builditems(),
          SizedBox(height: 10),
          _buildOptionsPayantes(),
          SizedBox(height: 15),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
              style: TextStyle(
                color: LocationTextStyle.regularWhiteTextStyle.color,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResaLocation(_habitation)),
                );
              },
              child: Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }

  _builditems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Container(
      width: width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              'Inclus',
              style: TextStyle(
                color: LocationTextStyle.subTitleboldTextStyle.color,
                fontSize: LocationTextStyle.subTitleboldTextStyle.fontSize,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: Iterable.generate(
                  widget._habitation.options.length,
                  (index) => Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._habitation.options[index].libelle,
                        ),
                        Text(
                          widget._habitation.options[index].description,
                          style: TextStyle(
                            fontStyle: LocationTextStyle
                                .regularGreyTextStyle.fontStyle,
                            color: LocationTextStyle.regularGreyTextStyle.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    var format = NumberFormat("### €");

    return Container(
      width: width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              'Options',
              style: TextStyle(
                color: LocationTextStyle.subTitleboldTextStyle.color,
                fontSize: LocationTextStyle.subTitleboldTextStyle.fontSize,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: Iterable.generate(
                  widget._habitation.optionspayantes.length,
                  (index) => Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    margin: EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._habitation.optionspayantes[index].libelle,
                        ),
                        Text(
                          format.format(
                              widget._habitation.optionspayantes[index].prix),
                          style: TextStyle(
                            fontStyle:
                                LocationTextStyle.priceGreyTextStyle.fontStyle,
                            color: LocationTextStyle.priceGreyTextStyle.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
