import 'package:flutter/material.dart';
import 'package:location/views/share/bottom_navigation_bar.dart';

class ValidationLocation extends StatefulWidget {
  const ValidationLocation({super.key});
  static const String routeName = "/validation-location";

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validation de la location"),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(0),
      body: const Center(
        child: Text("Validation de la location"),
      ),
    );
  }
}
