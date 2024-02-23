import 'package:location/models/facture.dart';

import 'habitation.dart';

class Location {
  int id;
  int idutilisateur;
  int idhabitation;
  DateTime dateDebut;
  DateTime dateFin;
  double montanttotal;
  double montantverse;
  Facture? facture;

  Habitation? habitation;
  List<OptionPayante> optionpayantes;

  Location(this.id, this.idutilisateur, this.idhabitation, this.dateDebut,
      this.dateFin, this.montanttotal, this.montantverse,
      {this.facture, this.habitation, this.optionpayantes = const []});

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idutilisateur = json['idutilisateur'],
        idhabitation = json['idhabitation'],
        dateDebut = DateTime.parse(json['datedebut']),
        dateFin = DateTime.parse(json['datefin']),
        montanttotal = json['montanttotal'],
        montantverse = json['montantverse'],
        facture =
            json['facture'] == null ? null : Facture.fromJson(json['facture']),
        optionpayantes = (json['locationOptionpayanteros'] as List)
            .map((item) => OptionPayante.fromJson(item))
            .toList();
}
