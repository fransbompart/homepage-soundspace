part of 'log_in_subscriber_cubit.dart';

enum FormStatus { invalid, valid, validating, posting, success, failure }

class LogInSubscriberState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Phone phone;

  const LogInSubscriberState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.phone = const Phone.pure(),
  });

  LogInSubscriberState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Phone? phone,
  }) =>
      LogInSubscriberState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        phone: phone ?? this.phone,
      );
  @override
  List<Object> get props => [formStatus, isValid, phone];
}
