import '../../../commons/result.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/mappers/user/user_mapper.dart';
import '../../../infrastructure/repositories/user/user_repository_impl.dart';
import '../../../infrastructure/services/network_manager.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkManager networkManager;

  UserRepositoryImpl({required this.networkManager});

  @override
  Future<Result<User>> logInUser(String number) async {
    final response =
        await networkManager.postRequest('auth/login', {'number': number});

    if (response.hasValue()) {
      return Result(
          value: UserMapper.fromJson(response.value.data['data']), error: null);
    } else {
      return Result(value: null, error: Error());
    }
  }
}
