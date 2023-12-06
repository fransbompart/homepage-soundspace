import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sign_in_bloc/application/useCases/user/log_in_use_case.dart';
import 'package:sign_in_bloc/infrastructure/inputs/phone.dart';
import 'package:sign_in_bloc/infrastructure/repositories/user/user_repository_impl.dart';

part 'log_in_subscriber_state.dart';

class LogInSubscriberCubit extends Cubit<LogInSubscriberState> {

  LogInSubscriberCubit() : super(LogInSubscriberInitial());

  void onSubmit() async {
    final isValid = Formz.validate([state.phone]);

  emit(
    state.copyWith(
      formStatus: FormStatus.validating,
      phone: Phone.dirty(state.phone.value),
      isValid: isValid,
    ),
  );

  if (isValid) {
    emit(state.copyWith(formStatus: FormStatus.posting));
    final logInUseCase = LogInUseCase(userRepository: UserRepositoryImpl());
    final logInResult = await logInUseCase.execute(state.phone.value);
    if (logInResult.hasValue()) {
      emit(state.copyWith(formStatus: FormStatus.success));
    } else {
      emit(state.copyWith(formStatus: FormStatus.failure));
    }
  }
    

    print('Cubit Submit: $state');
  }


  void phoneChanged( String value ) {
    final phone = Phone.dirty(value);
    emit(
      state.copyWith(
        formStatus: FormStatus.valid,
        phone: phone,
        isValid: Formz.validate([ phone ])
      )
    );
    print('Cubit Submit: $state');
  }

}
