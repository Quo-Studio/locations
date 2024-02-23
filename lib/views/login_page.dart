import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/cubits/auth_cubit.dart';
import 'package:location/models/user.dart';

import 'register_page.dart';

class LoginPageArgument {
  final String routeNameNext;

  LoginPageArgument(this.routeNameNext);
}

class LoginPage extends StatefulWidget {
  static String routeName = 'login';
  final String routeNameNext;
  final bool isValidating;

  const LoginPage(this.routeNameNext, this.isValidating, {Key? key})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          Image.asset('assets/images/locations/location.png'),
          const SizedBox(height: 30.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (value) => setState(() {
                    user = user?.copyWith(email: value);
                  }),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez un mot de passe';
                    }
                    return null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (value) => setState(() {
                    user = user?.copyWith(password: value);
                  }),
                ),
                CheckboxListTile(
                  title: const Text("Se souvenir de moi"),
                  contentPadding: EdgeInsets.zero,
                  value: rememberValue,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (newValue) {
                    setState(() {
                      rememberValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _login(context);
                    }
                  },
                  child: const Text('Valider'),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pas enregistré ?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(widget.routeNameNext),
                          ),
                        );
                      },
                      child: const Text('Créer un compte'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context
          .read<AuthCubit>()
          .login("john.doe@gmail.com", "1234", context, widget.isValidating);
    }
  }
}
