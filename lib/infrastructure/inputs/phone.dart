import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Phone extends FormzInput<String, PhoneError> {

  // Call super.pure to represent an unmodified form input.
  const Phone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Phone.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PhoneError.empty ) return 'Ingresa tu número de teléfono.';
    if ( displayError == PhoneError.length ) return 'El numero debe tener 10 o 12 caracteres.';
    if ( displayError == PhoneError.format ) return 'Siga el formato de ejemplo: 584241232323 o 4121232323';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return PhoneError.empty;
    if ( value.length != 10 && value.length != 12 ) return PhoneError.length;
    final phoneNumberPattern = RegExp(r'^(58424|58414|58424|414|424|412)\d+$');
    if (!phoneNumberPattern.hasMatch(value)) return PhoneError.format;

    return null;
  }
}