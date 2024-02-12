import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/presentation/views/find_person_form_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/home_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/missing_person_form_thank_you_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/missing_person_form_view.dart';
import 'package:safe_return/Features/signUpView/presentation/views/sign_up_view.dart';
import '../../Features/homeView/presentation/views/find_person_form_thank_you_view.dart';
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
      GoRoute(
        path: '/signUpView',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/homeView',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/missingPersonFormView',
        builder: (context, state) => const MissingPersonFormView(),
      ),
      GoRoute(
        path: '/missingPersonFormThankYouView',
        builder: (context, state) => const MissingPersonFormThankYouView(),
      ),
      GoRoute(
        path: '/findPersonFormView',
        builder: (context, state) => const FindPersonFormView(),
      ),
      GoRoute(
        path: '/findPersonFormThankYouView',
        builder: (context, state) => const FindPersonFormThankYouView(),
      ),
    ],
  );
}
