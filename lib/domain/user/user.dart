class User {
  final String id;
  final String? name;
  final String? email;
  final int? phoneNumber;
  final UserRol rol;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.rol});
}

enum UserRol { guest, subscriber }
