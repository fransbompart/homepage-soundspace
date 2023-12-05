import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sign_in_bloc/infrastructure/inputs/phone.dart';


part 'log_in_subscriber_state.dart';

class LogInSubscriberCubit extends Cubit<LogInSubscriberState> {
  LogInSubscriberCubit() : super(LogInSubscriberInitial());
  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        phone: Phone.dirty( state.phone.value ),

        isValid: Formz.validate([
          state.phone 
        ])
      )
    );



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
