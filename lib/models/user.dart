class User {
  String id;
  String email;
  String password;
  String? prenom;
  String? nom;

  User(
      {required this.id,
      required this.email,
      required this.password,
      this.prenom,
      this.nom});

  User copyWith(
      {String? id,
      String? email,
      String? password,
      String? prenom,
      String? nom}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
