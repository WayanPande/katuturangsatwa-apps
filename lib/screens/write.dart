import 'package:flutter/material.dart';
import 'package:katuturangsatwa/screens/redirect_login.dart';
import 'package:provider/provider.dart';

import '../config/AppRouter.dart';

class Write extends StatefulWidget {
  Write({Key? key}) : super(key: key);

  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State<Write> {
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
    final appService = Provider.of<AppService>(context);
    return !appService.loginState
        ? RedirectLogin()
        : Scaffold(
            appBar: AppBar(
              title: Text("Write"),
            ),
            body: Text("Write"),
          );
  }
}
