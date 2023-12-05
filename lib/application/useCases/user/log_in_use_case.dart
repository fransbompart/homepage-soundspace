import 'package:sign_in_bloc/domain/user/user.dart';

import '../../../domain/user/repository/user_repository.dart';
import '../../../result.dart';

class LogInUseCase {
  final UserRepository userRepository;

  LogInUseCase({required this.userRepository});

  Future<Result<User>> execute(String number) async {
    //TODO: guardar credenciales
    return await userRepository.logInUser(number);
  }
}