import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/useCases/user/get_user_profile_data_use_case.dart';
import 'package:sign_in_bloc/commons/result.dart';
import 'package:sign_in_bloc/domain/user/user.dart';

import '../../../domain/user/valueObjects/birth_day_value_object.dart';
import '../../../domain/user/valueObjects/email_address_value_object.dart';
import '../../../domain/user/valueObjects/gender_value_object.dart';
import '../../../domain/user/valueObjects/id_user_value_object.dart';
import '../../../domain/user/valueObjects/name_value_object.dart';
import '../../../domain/user/valueObjects/phone_value_object.dart';
import '../../../domain/user/valueObjects/user_role_value_object.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUserProfileDataUseCase fetchUserProfileDataUseCase;

  UserBloc({required this.fetchUserProfileDataUseCase})
      : super(UserState(
            user: User(
                id: const IdUser('1'),
                name: const UserName('Jorge'),
                email: const EmailAddress('jorge@jorge.com'),
                phone: const PhoneNumber('04125796934'),
                role: const UserRole('elPapa'),
                birthdate: BirthDate(DateTime(2000, 4, 19)),
                gender: const Gender('Masculino')))) {
    on<FetchUserProfileDataEvent>(_fetchUserProfileData);
  }

  void _fetchUserProfileData(
      FetchUserProfileDataEvent event, Emitter<UserState> emit) async {
    //final user = await fetchUserProfileDataUseCase.execute();
  }
}
