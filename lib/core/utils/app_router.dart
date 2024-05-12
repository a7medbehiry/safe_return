import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/presentation/views/find_person_form_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/home_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/missing_person_form_thank_you_view.dart';
import 'package:safe_return/Features/homeView/presentation/views/missing_person_form_view.dart';
import 'package:safe_return/Features/notificationView/presentation/views/notification_view.dart';
import 'package:safe_return/Features/openingView/presentation/views/opening_view.dart';
import 'package:safe_return/Features/profileView/presentation/views/edit_find_person_form_view.dart';
import 'package:safe_return/Features/profileView/presentation/views/edit_missing_person_form_view.dart';
import 'package:safe_return/Features/profileView/presentation/views/my_missing_reports_view.dart';
import 'package:safe_return/Features/profileView/presentation/views/profile_view.dart';
import 'package:safe_return/core/utils/widgets/custom_navigation_bottom_bar.dart';
import '../../Features/auth/presentation/views/check_mail_view.dart';
import '../../Features/auth/presentation/views/forget_password_view.dart';
import '../../Features/auth/presentation/views/login_view.dart';
import '../../Features/auth/presentation/views/reset_password_view.dart';
import '../../Features/auth/presentation/views/sign_up_view.dart';
import '../../Features/homeView/presentation/views/find_person_form_thank_you_view.dart';
import '../../Features/profileView/presentation/views/my_find_reports_view.dart';

abstract class AppRouter {
  static String initR = '/openingView';

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final _rootNavigatorHomeView =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorNotificationView =
      GlobalKey<NavigatorState>(debugLabel: 'shellNotification');
  static final _rootNavigatorProfileView =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final router = GoRouter(
    initialLocation: initR,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/openingView',
        name: 'openingView',
        builder: (context, state) {
          return OpeningView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/loginView',
        name: 'loginView',
        builder: (context, state) {
          return LoginView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/forgetPassword',
        name: 'forgetPassword',
        builder: (context, state) {
          return ForgetPasswordView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/checkMail',
        name: 'checkMail',
        builder: (context, state) {
          return CheckMailView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/resetPassword',
        name: 'resetPassword',
        builder: (context, state) {
          return ResetPasswordView(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/signUpView',
        name: 'signUpView',
        builder: (context, state) {
          return SignUpView(
            key: state.pageKey,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CustomNavigationBottomBar(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHomeView,
            routes: [
              GoRoute(
                path: '/homeView',
                name: 'homeView',
                builder: (context, state) {
                  return HomeView(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'missingPersonFormView',
                    name: 'missingPersonFormView',
                    builder: (context, state) {
                      return MissingPersonFormView(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'missingPersonFormThankYouView',
                    name: 'missingPersonFormThankYouView',
                    builder: (context, state) {
                      return MissingPersonFormThankYouView(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'findPersonFormView',
                    name: 'findPersonFormView',
                    builder: (context, state) {
                      return FindPersonFormView(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'findPersonFormThankYouView',
                    name: 'findPersonFormThankYouView',
                    builder: (context, state) {
                      return FindPersonFormThankYouView(
                        key: state.pageKey,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorNotificationView,
            routes: [
              GoRoute(
                path: '/notificationView',
                name: 'notificationView',
                builder: (context, state) {
                  return NotificationView(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfileView,
            routes: [
              GoRoute(
                path: '/profileView',
                name: 'Profile',
                builder: (context, state) {
                  return ProfileView(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'myMissingReportsView',
                    name: 'myMissingReportsView',
                    builder: (context, state) {
                      return MyMissingReportsView(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'myFindReportsView',
                    name: 'myFindReportsView',
                    builder: (context, state) {
                      return MyFindReportsView(
                        key: state.pageKey,
                      );
                    },
                  ),
                  GoRoute(
                    path: r'editMissingPersonFormView/:_id',
                    name: 'editMissingPersonFormView',
                    builder: (context, state) {
                      String? id = state.pathParameters['_id'];

                      return EditMissingPersonFormView(
                        key: state.pageKey,
                        id: id,
                      );
                    },
                  ),
                  GoRoute(
                    path: r'editFindPersonFormView/:_id',
                    name: 'editFindPersonFormView',
                    builder: (context, state) {
                      String? id = state.pathParameters['_id'];
                      return EditFindPersonFormView(
                        key: state.pageKey,
                        id: id,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
