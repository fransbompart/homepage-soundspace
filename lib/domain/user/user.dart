import 'package:sign_in_bloc/domain/user/valueObjects/birthdate_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/email_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/name_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/phone_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/role_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/id_value_object.dart';

class User {
  final IdUser id;
  final UserName? name;
  final EmailAddress? email;
  final PhoneNumber? phone;
  final UserRole? role;
  final BirthDate? birthdate;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.birthdate,
  });
}
