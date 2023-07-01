import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/screens/dashboard.dart';
import 'package:katuturangsatwa/screens/discover.dart';
import 'package:katuturangsatwa/screens/login.dart';
import 'package:katuturangsatwa/screens/profile.dart';
import 'package:katuturangsatwa/screens/reader.dart';
import 'package:katuturangsatwa/screens/register.dart';
import 'package:katuturangsatwa/screens/story_detail.dart';
import 'package:katuturangsatwa/screens/story_input.dart';
import 'package:katuturangsatwa/screens/write.dart';
import 'package:katuturangsatwa/widgets/scaffold_bottom_navbar.dart';

import '../screens/categories_detail.dart';
import '../screens/onboarding.dart';
import '../config/AppRouter.dart';
import '../widgets/scaffold_with_navbar_tabitem.dart';

class AppRouter {
  late final AppService appService;

  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  final tabs = [
    ScaffoldWithNavBarTabItem(
      initialLocation: APP_PAGE.home.toPath,
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home),
      label: 'Home',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: APP_PAGE.discover.toPath,
      icon: const Icon(Icons.explore_outlined),
      selectedIcon: const Icon(Icons.explore),
      label: 'Discover',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: APP_PAGE.write.toPath,
      icon: const Icon(Icons.edit_outlined),
      selectedIcon: const Icon(Icons.edit),
      label: 'Write',
    ),
    ScaffoldWithNavBarTabItem(
      initialLocation: APP_PAGE.profile.toPath,
      icon: const Icon(Icons.person_outline),
      selectedIcon: const Icon(Icons.person),
      label: 'Person',
    ),
  ];

  // private navigators
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: APP_PAGE.home.toPath,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldWithBottomNavBar(
              tabs: tabs, navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(navigatorKey: _shellNavigatorKey, routes: [
            GoRoute(
              path: APP_PAGE.home.toPath,
              name: APP_PAGE.home.toName,
              builder: (BuildContext context, GoRouterState state) {
                return Dashboard();
              },
              pageBuilder: defaultPageBuilder(Dashboard()),
            ),
          ]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: APP_PAGE.discover.toPath,
                name: APP_PAGE.discover.toName,
                pageBuilder: defaultPageBuilder(Discover()),
                builder: (BuildContext context, GoRouterState state) {
                  return Discover();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: APP_PAGE.write.toPath,
                name: APP_PAGE.write.toName,
                pageBuilder: defaultPageBuilder(Write()),
                builder: (BuildContext context, GoRouterState state) {
                  return Write();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: APP_PAGE.profile.toPath,
                name: APP_PAGE.profile.toName,
                pageBuilder: defaultPageBuilder(Profile()),
                builder: (BuildContext context, GoRouterState state) {
                  return Profile();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: APP_PAGE.login.toPath,
        name: APP_PAGE.login.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return Login();
        },
        pageBuilder: defaultPageBuilder(Login()),
      ),
      GoRoute(
        path: APP_PAGE.register.toPath,
        name: APP_PAGE.register.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return Register();
        },
        pageBuilder: defaultPageBuilder(Register()),
      ),
      GoRoute(
        path: APP_PAGE.storyInput.toPath,
        name: APP_PAGE.storyInput.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return StoryInput(id: state.queryParameters['id']);
        },
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: StoryInput(id: state.queryParameters['id']),
        ),
      ),
      GoRoute(
        path: "${APP_PAGE.storyDetail.toPath}/:id",
        name: APP_PAGE.storyDetail.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return StoryDetail(
            id: state.pathParameters['id'] ?? "",
          );
        },
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: StoryDetail(id: state.pathParameters["id"] ?? ""),
        ),
      ),
      GoRoute(
        path: APP_PAGE.reader.toPath,
        name: APP_PAGE.reader.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return Reader(
            text: state.queryParameters['text'] ?? "",
            title: state.queryParameters['title'] ?? "",
          );
        },
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: Reader(
            text: state.queryParameters["text"] ?? "",
            title: state.queryParameters['title'] ?? "",
          ),
        ),
      ),
      GoRoute(
        path: APP_PAGE.onBoarding.toPath,
        name: APP_PAGE.onBoarding.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnBoardingPage(),
        pageBuilder: defaultPageBuilder(const OnBoardingPage()),
      ),
      GoRoute(
        path: APP_PAGE.categoriesDetail.toPath,
        name: APP_PAGE.categoriesDetail.toName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return CategoriesDetail(
            id: state.queryParameters['id'] ?? "",
            title: state.queryParameters['title'] ?? "",
          );
        },
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: CategoriesDetail(
            id: state.queryParameters["id"] ?? "",
            title: state.queryParameters['title'] ?? "",
          ),
        ),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation(APP_PAGE.login.toName);
      final homeLocation = state.namedLocation(APP_PAGE.home.toName);
      final onboardLocation = state.namedLocation(APP_PAGE.onBoarding.toName);
      final registerLocation = state.namedLocation(APP_PAGE.register.toName);

      final isLogedIn = appService.loginState;
      final isOnboarded = appService.onboarding;

      final isGoingToLogin = state.matchedLocation == loginLocation;
      final isGoingToOnboard = state.matchedLocation == onboardLocation;
      final isGoingToRegister = state.matchedLocation == registerLocation;

      if (!isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
        // If not logedin and not going to login redirect to Login
      }

      if (isOnboarded && isGoingToLogin) {
        if (isGoingToRegister) return registerLocation;
        return loginLocation;
        // If all the scenarios are cleared but still going to any of that screen redirect to Home
      }

      if ((isLogedIn && isGoingToLogin) || (isOnboarded && isGoingToOnboard)) {
        return homeLocation;
      }

      return null;
    },
    refreshListenable: appService,
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };
