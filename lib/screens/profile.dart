import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/config/AppRouter.dart';
import 'package:katuturangsatwa/providers/users.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Users>(context, listen: false)
          .getUserData();
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  logout() {
    Provider.of<Users>(context, listen: false).removeUserData();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final appService = Provider.of<AppService>(context);
    final user = Provider.of<Users>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(user?.username ?? "koosng"),
            ElevatedButton(
              onPressed: () {
                if(appService.loginState) {
                  logout();
                  authService.logOut();
                }
                context.pushNamed(APP_PAGE.login.toName);
              },
              child: Text(appService.loginState ? "Logout" : "Login"),
            ),
          ],
        ),
      ),
    );
  }
}
