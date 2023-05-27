import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/route_utils.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  bool isPassShown = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'FullName',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: !isPassShown,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassShown = !isPassShown;
                          });
                        },
                        icon: Icon(
                          isPassShown ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: !isPassShown,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Re-Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassShown = !isPassShown;
                          });
                        },
                        icon: Icon(
                          isPassShown ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {

                          },
                          child: const Text(
                            "Register",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah memiliki akun ?",
                        style: TextStyle(
                          color: Color(0xFFAFA1A1),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(
                              context.namedLocation(APP_PAGE.login.toName));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}