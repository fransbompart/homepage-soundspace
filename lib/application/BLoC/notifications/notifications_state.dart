part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus status;

  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
  }) =>
      NotificationsState(
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [status];
}
