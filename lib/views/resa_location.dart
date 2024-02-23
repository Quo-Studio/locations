import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location/cubits/auth_cubit.dart';
import 'package:location/cubits/auth_state.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/login_page.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';
import 'package:location/views/share/habitation_option_payante.dart';
import 'package:location/share/location_style.dart';
import 'package:location/views/validation_location.dart';

class ResaLocation extends StatefulWidget {
  final Habitation habitation;
  const ResaLocation(this.habitation, {Key? key}) : super(key: key);

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  late String formattedDateDebut;
  late String formattedDateFin;

  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionsPayantesChecks = [];
  double prixTotal = 0;

  var format = NumberFormat("### €");

  late Habitation habitation;

  @override
  initState() {
    super.initState();
    habitation = widget.habitation;
    _loadOptionsPayantes();
  }

  void _loadOptionsPayantes() {
    habitation.optionspayantes.forEach((option) {
      optionsPayantesChecks.add(OptionPayanteCheck(
        option.id,
        option.libelle,
        false,
        option.description,
        prix: option.prix,
      ));
    });
  }

  Widget _buildOptionsPayantes(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: Iterable.generate(optionsPayantesChecks.length, (index) {
          return CheckboxListTile(
            title: Text(optionsPayantesChecks[index].libelle +
                " (" +
                format.format(optionsPayantesChecks[index].prix) +
                ")"),
            subtitle: Text(optionsPayantesChecks[index].description),
            value: optionsPayantesChecks[index].checked,
            onChanged: (bool? value) {
              setState(() {
                optionsPayantesChecks[index].checked = value!;
                if (value) {
                  prixTotal += optionsPayantesChecks[index].prix;
                } else {
                  prixTotal -= optionsPayantesChecks[index].prix;
                }
              });
            },
            secondary: const Icon(Icons.shopping_cart),
          );
        }).toList(),
      ),
    );
  }

  _buildResume() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text(habitation.libelle),
      subtitle: Text(habitation.adresse),
      tileColor: LocationStyle.colorGrey,
    );
  }

  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(
        start: dateDebut,
        end: dateFin,
      ),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
        prixTotal = habitation.prixmois *
            (dateFin.difference(dateDebut).inDays / 30) *
            int.parse(nbPersonnes);
        optionsPayantesChecks.forEach((option) {
          option.checked = false;
        });
      });
    }
  }

  _buildDates() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.date_range,
          ),
          SizedBox(width: 10),
          GestureDetector(
            child: Text(DateFormat('d MMM. y', 'fr_FR').format(dateDebut)),
            onTap: () => dateTimeRangePicker(),
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: LocationStyle.colorPurple,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Icon(Icons.date_range),
          SizedBox(width: 10),
          GestureDetector(
            child: Text(DateFormat('d MMM. y', 'fr_FR').format(dateFin)),
            onTap: () => dateTimeRangePicker(),
          ),
        ],
      ),
    );
  }

  _buildNbPersonnes() {
    List<DropdownMenuItem<String>> items = [];
    for (var i = 1; i <= 10; i++) {
      items.add(DropdownMenuItem(
        value: i.toString(),
        child: Text(i.toString()),
      ));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.people),
          SizedBox(width: 10),
          Text('Nombre de personnes', style: LocationTextStyle.boldTextStyle),
          SizedBox(width: 10),
          DropdownButton(
            value: nbPersonnes,
            items: items,
            onChanged: (value) {
              setState(() {
                nbPersonnes = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget TotalWidget(double prixTotal) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: LocationStyle.colorPurple,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'TOTAL',
                style: LocationTextStyle.boldTextStyle,
              ),
            ),
          ),
          Text(
            format.format(prixTotal),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildRentButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(LocationStyle.colorPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () async {
            if (state is AuthAuthenticated) {
              Navigator.pushNamed(context, ValidationLocation.routeName);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage('/home', true)));
            }
          },
          child: Text('Louer', style: LocationTextStyle.priceTextStyle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(0),
      body: ListView(
        padding: EdgeInsets.all(4),
        children: [
          _buildResume(),
          SizedBox(height: 10),
          _buildDates(),
          SizedBox(height: 10),
          _buildNbPersonnes(),
          if (optionsPayantesChecks.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Options payantes',
                style: LocationTextStyle.boldTextStyle,
              ),
            ),
          _buildOptionsPayantes(context),
          SizedBox(height: 30),
          TotalWidget(prixTotal),
          SizedBox(height: 10),
          _buildRentButton(),
        ],
      ),
    );
  }
}
