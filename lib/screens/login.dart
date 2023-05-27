import 'package:flutter/material.dart';

import 'package:katuturangsatwa/router/app_router.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppRouter>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                authService.login();
              },
              child: Text("login"))
        ],
      ),
    );
  }
}
