import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/config/AppRouter.dart';
import 'package:katuturangsatwa/providers/users.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/screens/redirect_login.dart';
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
      Provider.of<Users>(context, listen: false).getUserData();
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

    return !appService.loginState
        ? const RedirectLogin()
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.pushNamed(APP_PAGE.profileUpdate.toName);
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                )
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5, color: Theme.of(context).primaryColorLight),
                        shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(75),
                        child: Image.network(
                          dotenv.env['PROFILE_IMG_URL']! + (user?.gambar ?? ""),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 3,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    user?.nama ?? "",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user?.email ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (appService.loginState) {
                        logout();
                        authService.logOut();
                      }
                      context.pushNamed(APP_PAGE.login.toName);
                    },
                    child: Text(appService.loginState ? "Logout" : "Login"),
                  ),
                ],
              ),
            ))),
          );
  }
}
