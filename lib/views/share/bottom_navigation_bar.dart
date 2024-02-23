import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/cubits/auth_cubit.dart';
import 'package:location/cubits/auth_state.dart';
import 'package:location/views/location_list.dart';
import 'package:location/views/profil.dart';
import 'package:location/views/share/badge.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int indexSelected;
  const BottomNavigationBarWidget(this.indexSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool isUserNotConnected = true;
        if (state is AuthInitial) {
          isUserNotConnected = true;
        } else if (state is AuthAuthenticated) {
          isUserNotConnected = false;
        } else if (state is AuthUnauthenticated) {
          isUserNotConnected = true;
        }
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: indexSelected,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: isUserNotConnected
                  ? const Icon(Icons.shopping_cart_outlined)
                  : BadgeWidget(
                      value: 0,
                      top: 0,
                      right: 0,
                      child: const Icon(Icons.shopping_cart),
                    ),
              label: 'Locations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          onTap: (index) {
            String page = '/home';
            switch (index) {
              case 2:
                page = LocationList.routeName;
                break;
              case 3:
                page = Profil.routeName;
            }

            Navigator.pushNamedAndRemoveUntil(context, page, (route) => false);
          },
        );
      },
    );
  }
}
