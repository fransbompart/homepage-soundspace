import 'package:sign_in_bloc/commons/result.dart';
import 'package:sign_in_bloc/domain/user/user.dart';

abstract class UserRepository {
  Future<Result<User>> logInUser(String number);
  Future<Result<User>> fetchUserProfileData();
  //Future<Result<User>> signUpUser(User newUser);
}
