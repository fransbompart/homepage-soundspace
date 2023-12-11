import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/auth/auth_bloc.dart';
import 'package:sign_in_bloc/commons/error.dart';

import '../../../infrastructure/presentation/pages/logIn/inputs/phone.dart';
import '../../useCases/user/log_in_use_case.dart';

part 'log_in_subscriber_event.dart';
part 'log_in_subscriber_state.dart';

class LogInSubscriberBloc
    extends Bloc<LogInSubscriberEvent, LogInSubscriberState> {
  final LogInUseCase logInUseCase;
  LogInSubscriberBloc({required this.logInUseCase})
      : super(const LogInSubscriberState()) {
    on<LogInSubscriberSubmitted>(_onSubmited);
    on<LogInSubscriberPhoneChanged>(_phoneChanged);
  }

  Future<void> _onSubmited(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
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
        GetIt.instance.get<AuthBloc>().add(UserAuthenticatedEvent());
        emit(state.copyWith(formStatus: FormStatus.success));
      } else if (logInResult.error! is NoAuthoizedError) {
        emit(state.copyWith(formStatus: FormStatus.invalid));
      } else {
        emit(state.copyWith(formStatus: FormStatus.failure));
      }
    }
  }

  Future<void> _phoneChanged(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
        formStatus: FormStatus.valid,
        phone: phone,
        isValid: Formz.validate([phone])));
  }

  void onPhoneChanged(String value) {
    add(LogInSubscriberPhoneChanged(phone: value));
  }
}
