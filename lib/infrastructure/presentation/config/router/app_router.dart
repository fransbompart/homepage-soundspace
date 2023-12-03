import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_bloc/application/BLoC/auth/auth_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/homePage/home_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/landing/landing_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/background.dart';
import '../../artistDetail/artist_detail.dart';

part 'route_guard.dart';

class AppNavigator {
  late final GoRouter _routes;
  final AuthRouteGuard authRouteGuard;
  final SubscriptionRouteGuard subscriptionRouteGuard;

  AppNavigator(
      {required this.authRouteGuard, required this.subscriptionRouteGuard}) {
    _routes = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Background(child: LandingPage()),
          redirect: _authProtectedNavigation,
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Background(child: HomePage()),
        ),
        GoRoute(
          path: '/artist',
          builder: (context, state) => const Background(child: ArtistDetail()),
          redirect: _subscriptionProtectedNavigation,
        ),
      ],
    );
  }

  get routerDelegate {
    return _routes.routerDelegate;
  }

  get routeInformationParser {
    return _routes.routeInformationParser;
  }

  get routeInformationProvider {
    return _routes.routeInformationProvider;
  }

  void pop() {
    _routes.pop();
  }

  void navigateTo(String routeName) {
    _routes.go(routeName);
  }

  String? _authProtectedNavigation(BuildContext context, GoRouterState state) {
    if (authRouteGuard.canNavigate()) {
      return '/home';
    }
    return null;
  }

  String? _subscriptionProtectedNavigation(
      BuildContext context, GoRouterState state) {
    if (subscriptionRouteGuard.canNavigate()) {
      return null;
    }
    return '/home';
  }
}
