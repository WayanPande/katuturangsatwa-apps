import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/app_router.dart';
import 'package:katuturangsatwa/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/AppRouter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences
      .getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key? key, required this.sharedPreferences,}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;
  late AuthService authService;
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    authService = AuthService();
    authSubscription = authService.onAuthStateChange.listen(onAuthStateChange);
    super.initState();
  }

  void onAuthStateChange(bool login) {
    appService.loginState = login;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        Provider<AuthService>(create: (_) => authService),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            title: 'Katuturangsatwa',
            theme: ThemeData(
              colorSchemeSeed: Colors.green[700],
              useMaterial3: true,
            ),
            routerConfig: goRouter,
          );
        },
      )
    );
  }
}
