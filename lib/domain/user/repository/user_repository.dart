import '../user.dart';
import '../../../result.dart';

abstract class UserRepository {
  Future<Result<User>> logInUser(String number);
  Future<Result<User>> signUpUser(User newUser);
}