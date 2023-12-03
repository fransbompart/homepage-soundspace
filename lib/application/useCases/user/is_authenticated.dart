import 'package:sign_in_bloc/commons/result.dart';

import '../../services/local_storage.dart';

class IsAuthenticatedUseCase {
  final LocalStorage localStorage;

  IsAuthenticatedUseCase({required this.localStorage});

  Result<bool> execute() {
    try {
      final token = localStorage.getValue('token'); //esto se puede mejorar
      if (token != null) {
        //sera necesario comprobar si el token aun es valido? preguntar al backend
        return Result<bool>(value: true, error: null);
      } else {
        return Result<bool>(value: false, error: null);
      }
    } catch (e) {
      return Result<bool>(value: false, error: Error());
    }
  }
}
