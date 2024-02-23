import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/cubits/auth_state.dart';
import 'package:location/models/user.dart';
import 'package:location/views/my_home_page.dart';
import 'package:location/views/validation_location.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password, BuildContext context,
      bool isValidating) async {
    emit(AuthLoading());

    try {
      await Future.delayed(Duration(seconds: 1));

      final user = User(
          id: '1',
          email: 'john.doe@gmail.fr',
          password: '1234',
          prenom: "John",
          nom: "Doe");

      print(isValidating);

      Navigator.pushNamed(context,
          isValidating ? ValidationLocation.routeName : MyHomePage.routeName);

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }
}
