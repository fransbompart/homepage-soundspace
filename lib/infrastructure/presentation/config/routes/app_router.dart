import 'package:go_router/go_router.dart';
import 'package:sign_in_bloc/infrastructure/presentation/landing/landing_page.dart';

final publicRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const LandingPage()),
]);
