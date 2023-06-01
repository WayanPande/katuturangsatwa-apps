import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/route_utils.dart';

class RedirectLogin extends StatelessWidget {
  RedirectLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("You need to login"),
        ElevatedButton(
          onPressed: () {
            context.pushNamed(APP_PAGE.login.toName);
          },
          child: Text("Login"),
        ),
      ],
    );
  }
}
