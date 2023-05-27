import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/screens/dashboard.dart';
import 'package:katuturangsatwa/screens/login.dart';
import 'package:katuturangsatwa/screens/register.dart';
import 'package:katuturangsatwa/screens/splashscreen.dart';

import '../screens/onboarding.dart';
import '../config/AppRouter.dart';

class AppRouter {
  late final AppService appService;

  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.home.toPath,
        name: APP_PAGE.home.toName,
        builder: (BuildContext context, GoRouterState state) {
          return Dashboard();
        },
      ),
      GoRoute(
          path: APP_PAGE.login.toPath,
          name: APP_PAGE.login.toName,
          builder: (BuildContext context, GoRouterState state) {
            return Login();
          },
          routes: [
            GoRoute(
              path: APP_PAGE.register.toPath,
              name: APP_PAGE.register.toName,
              builder: (BuildContext context, GoRouterState state) {
                return Register();
              },
            ),
          ]),
      GoRoute(
        path: APP_PAGE.splash.toPath,
        name: APP_PAGE.splash.toName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: APP_PAGE.onBoarding.toPath,
        name: APP_PAGE.onBoarding.toName,
        builder: (context, state) => const OnBoardingPage(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation(APP_PAGE.login.toName);
      final homeLocation = state.namedLocation(APP_PAGE.home.toName);
      final splashLocation = state.namedLocation(APP_PAGE.splash.toName);
      final onboardLocation = state.namedLocation(APP_PAGE.onBoarding.toName);
      final registerLocation = state.namedLocation(APP_PAGE.register.toName);

      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;
      final isOnboarded = appService.onboarding;

      final isGoingToLogin = state.matchedLocation == loginLocation;
      final isGoingToInit = state.matchedLocation == splashLocation;
      final isGoingToOnboard = state.matchedLocation == onboardLocation;
      final isGoingToRegister = state.matchedLocation == registerLocation;

      // If not Initialized and not going to Initialized redirect to Splash
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
        // If not onboard and not going to onboard redirect to OnBoarding
      } else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
        // If not logedin and not going to login redirect to Login
      } else if (isInitialized && isOnboarded && !isLogedIn) {
        if (isGoingToRegister) return registerLocation;
        return loginLocation;
        // If all the scenarios are cleared but still going to any of that screen redirect to Home
      } else if ((isLogedIn && isGoingToLogin) ||
          (isInitialized && isGoingToInit) ||
          (isOnboarded && isGoingToOnboard)) {
        return homeLocation;
      } else {
        // Else Don't do anything
        return null;
      }
    },
    refreshListenable: appService,
  );
}
