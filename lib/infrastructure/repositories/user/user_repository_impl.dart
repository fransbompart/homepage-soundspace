import 'package:sign_in_bloc/infrastructure/services/api_connection_manager.dart';

import '../../../commons/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/mappers/user/user_mapper.dart';

class UserRepositoryImpl extends UserRepository {
  final IApiConnectionManager _apiConnectionManager;

  UserRepositoryImpl({required IApiConnectionManager apiConnectionManager})
      : _apiConnectionManager = apiConnectionManager;

  @override
  Future<Result<User>> logInUser(String number) async {
    final response = await _apiConnectionManager
        .request('auth/login', 'POST', body: {'number': number});

    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']), error: null);
    } else {
      return Result<User>(value: null, error: response.error);
    }
  }

  //! ES LITERALMENTE LO MISMO, CAPAZ CAMBIAR EL NOMBRE PARA NO ESTAR REPITIENDO?
  @override
  Future<Result<User>> fetchUserProfileData() async {
    final response =
        await _apiConnectionManager.request('user/profileData', 'GET');

    if (response.hasValue()) {
      return Result<User>(
          value: UserMapper.fromJson(response.value.data['data']), error: null);
    } else {
      return Result<User>(value: null, error: response.error);
    }
  }
}
