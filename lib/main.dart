import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/providers/stories.dart';
import 'package:katuturangsatwa/providers/users.dart';
import 'package:katuturangsatwa/router/app_router.dart';
import 'package:katuturangsatwa/services/auth_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/AppRouter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppService appService;
  late AuthService authService;
  late StreamSubscription<bool> authSubscription;
  late Stories stories;
  late Users user;

  @override
  void initState() {
    appService = AppService(widget.sharedPreferences);
    authService = AuthService();
    authSubscription = authService.onAuthStateChange.listen(onAuthStateChange);
    stories = Stories();
    user = Users();
    onStartUp();
    super.initState();
  }

  void onAuthStateChange(bool login) {
    appService.loginState = login;
  }

  void onStartUp() async {
    await appService.onAppStart();
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
        ChangeNotifierProvider<Stories>(create: (_) => stories),
        ChangeNotifierProvider<Users>(create: (_) => user)
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider.of<AppRouter>(context, listen: false).router;
          return GlobalLoaderOverlay(
            child: MaterialApp.router(
              title: 'Katuturangsatwa',
              theme: ThemeData(
                  colorSchemeSeed: Colors.blue,
                  useMaterial3: true,
                  fontFamily: "Sen"),
              debugShowCheckedModeBanner: false,
              routerConfig: goRouter,
            ),
          );
        },
      ),
    );
  }
}
