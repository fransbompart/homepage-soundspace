import 'package:sign_in_bloc/application/services/local_storage.dart';
import 'package:sign_in_bloc/commons/result.dart';
import 'package:sign_in_bloc/domain/user/repository/user_repository.dart';
import 'package:sign_in_bloc/domain/user/user.dart';

class FetchUserProfileDataUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  FetchUserProfileDataUseCase(
      {required this.userRepository, required this.localStorage});

  Future<Result<User>> execute() async {
    final result = await userRepository.fetchUserProfileData();

    if (result.hasValue()) {
      await localStorage.setKeyValue('token', result.value!.id.id);
    }

    return result;
  }
}
