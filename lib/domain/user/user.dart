import 'valueObjects/birth_day_value_object.dart';
import 'valueObjects/email_address_value_object.dart';
import 'valueObjects/id_user_value_object.dart';
import 'valueObjects/name_value_object.dart';
import 'valueObjects/phone_value_object.dart';
import 'valueObjects/user_role_value_object.dart';

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
