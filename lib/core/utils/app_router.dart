import 'package:go_router/go_router.dart';
import '../../Features/loginView/presentation/views/login_view.dart';
import '../../Features/openingView/presentation/views/opening_view.dart';

abstract class AppRouter {
  // GoRouter configuration
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OpeningView(),
      ),
      GoRoute(
        path: '/loginView',
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
