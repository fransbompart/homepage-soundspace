part of 'app_router.dart';

class AuthRouteGuard {
  final AuthBloc authBloc;

  AuthRouteGuard({required this.authBloc});

  bool canNavigate() => authBloc.state is Authenticated;
}

class SubscriptionRouteGuard {
  //TODO: implementar subscriptionBLoC
  final AuthBloc authBloc;

  SubscriptionRouteGuard({required this.authBloc});

  bool canNavigate() => authBloc.state is Authenticated;
}
