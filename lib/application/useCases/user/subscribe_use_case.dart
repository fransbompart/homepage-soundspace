import 'package:sign_in_bloc/application/services/local_storage.dart';
import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../commons/result.dart';
import '../../../domain/user/repository/user_repository.dart';

class SignUpUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  SignUpUseCase({required this.userRepository, required this.localStorage});

  Future<Result<User>> execute(String number, String operator) async {
    final result = await userRepository.signUpUser(number,operator);
    if (result.hasValue()) {
      await localStorage.setKeyValue('token', result.value!.id.id);
      //TODO: esto no se si es asi, Francis revisalo plej
    }

    return result;
  }
}