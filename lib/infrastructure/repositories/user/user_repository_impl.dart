import 'package:sign_in_bloc/domain/user/repository/user_repository.dart';
import 'package:sign_in_bloc/infrastructure/mappers/user_mapper.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import 'package:sign_in_bloc/result.dart'; 

import '../../../domain/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkManager networkManager = NetworkManager(
       apiPath:
           'https://soundspace-api-production.up.railway.app/api/'); 

   @override
   Future<Result<User>> logInUser(String number) async {
    final response = await networkManager.postRequest('auth/login', {'number': number});
    
    if (response.hasValue()) {
      return Result(value: UserMapper.fromJson(response.value), error: null);
    } else {
      return Result(value: null, error: Error());
    }
   }
}