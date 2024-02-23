import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/cubits/auth_cubit.dart';
import 'package:location/views/location_list.dart';
import 'package:location/views/login_page.dart';
import 'package:location/views/my_home_page.dart';
import 'package:location/views/profil.dart';
import 'package:location/views/validation_location.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Locations',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'Locations'),
        routes: {
          MyHomePage.routeName: (context) => MyHomePage(title: "Mes locations"),
          Profil.routeName: (context) => const Profil(),
          LoginPage.routeName: (context) => const LoginPage('/', false),
          LocationList.routeName: (context) => LocationList(),
          ValidationLocation.routeName: (context) => const ValidationLocation(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ]);
  }
}
