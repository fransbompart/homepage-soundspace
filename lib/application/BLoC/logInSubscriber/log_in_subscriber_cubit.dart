import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../infrastructure/presentation/pages/logIn/inputs/phone.dart';
import '../../useCases/user/log_in_use_case.dart';

part 'log_in_subscriber_state.dart';

class LogInSubscriberCubit extends Cubit<LogInSubscriberState> {
  final LogInUseCase logInUseCase;
  LogInSubscriberCubit({required this.logInUseCase})
      : super(const LogInSubscriberState());

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
      final logInResult = await logInUseCase.execute(state.phone.value);
      if (logInResult.hasValue()) {
        emit(state.copyWith(formStatus: FormStatus.success));
      } else {
        emit(state.copyWith(formStatus: FormStatus.failure));
      }
    }
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
        formStatus: FormStatus.valid,
        phone: phone,
        isValid: Formz.validate([phone])));
  }
}
