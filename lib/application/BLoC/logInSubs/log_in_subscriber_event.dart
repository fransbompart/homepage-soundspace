part of 'log_in_subscriber_bloc.dart';

abstract class LogInSubscriberEvent extends Equatable {
  final String phone;
  const LogInSubscriberEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class LogInSubscriberSubmitted extends LogInSubscriberEvent {
  const LogInSubscriberSubmitted({required String phone}) : super(phone: phone);
}

class LogInSubscriberPhoneChanged extends LogInSubscriberEvent {
  const LogInSubscriberPhoneChanged({required String phone})
      : super(phone: phone);
}
