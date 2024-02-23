import 'package:flutter/material.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});
  static const String routeName = "/profil";

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Profil à faire',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
