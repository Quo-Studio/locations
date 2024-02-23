import 'package:flutter/material.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final String routeNameNext;
  const RegisterPage(this.routeNameNext, {Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enregistrement',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez votre prénom';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Prénom',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Entrez votre nom';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Nom',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Enregister',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Déjà un compte ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(widget.routeNameNext, false),
                            ),
                          );
                        },
                        child: const Text('Enregistrement'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
