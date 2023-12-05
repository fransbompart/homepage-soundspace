import '../../domain/user/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['codigo_usuario'],
      phone: json['number'],
      // Otros campos del usuario que puedan estar presentes en el JSON
      // Ejemplo: email, dirección, etc.
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'number': user.phone,
      'codigo_usuario': user.name,
      // Otros campos del usuario que se deben convertir a JSON
    };
  }
}