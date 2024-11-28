import 'package:go_router/go_router.dart';
import 'package:looksy_app/presentation/pages/navigation/navigation.dart';
import 'package:looksy_app/presentation/pages/onboarding/login.dart';
import 'package:looksy_app/presentation/pages/onboarding/onboarding.dart';
import 'package:looksy_app/presentation/pages/onboarding/registration.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
        path: '/home',
        pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NavigationPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
        routes: [
          GoRoute(
            path: 'tips',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NavigationPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          ),
          GoRoute(
            path: 'scan',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NavigationPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          ),
          GoRoute(
            path: 'history',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NavigationPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const NavigationPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          ),
        ]),
  ],
  redirect: (context, state) {
    if (state.uri.toString() == '/') {
      return '/onboarding';
    }
    return null;
  },
);

GoRouter getRoute() => _router;
