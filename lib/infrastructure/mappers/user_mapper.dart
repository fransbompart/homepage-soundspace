import 'package:sign_in_bloc/domain/user/valueObjects/id_value_object.dart';

import '../../domain/user/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      id: IdUser (json ['data']['codigo_usuario']),
      // Otros campos del usuario que puedan estar presentes en el JSON
      // Ejemplo: email, dirección, etc.
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'number': user.phone,
      'codigo_usuario': user.id,
      // Otros campos del usuario que se deben convertir a JSON
    };
  }
}