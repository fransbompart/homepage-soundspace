import 'package:sign_in_bloc/application/services/local_storage.dart';
import 'package:sign_in_bloc/domain/user/user.dart';
import '../../../commons/result.dart';
import '../../../domain/user/repository/user_repository.dart';

class LogInUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;
  LogInUseCase({required this.userRepository, required this.localStorage});

  Future<Result<User>> execute(String number) async {
    final result = await userRepository.logInUser(number);
    //TODO: Establecer bien que vamos a guardar en el local storage, por ahora lo simulamos asi
    if (result.hasValue()) {
      await localStorage.setKeyValue('token', result.value!.id.id);
    }

    return result;
  }
}
