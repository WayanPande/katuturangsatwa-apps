import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:katuturangsatwa/router/app_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import '../services/auth_services.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool isPassShown = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Username cannot be empty";
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
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
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          }
                        }
                        return null;
                      },
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
                            isPassShown
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                              if (_formKey.currentState!.validate()) {
                                authService
                                    .login(LoginData(
                                        username: username.text,
                                        password: password.text))
                                    .then((value) {
                                  if (value) {
                                    Provider.of<Users>(context, listen: false)
                                        .getUserData();
                                    context.goNamed(APP_PAGE.home.toName);
                                  }
                                });
                              }
                            },
                            child: const Text(
                              "Login",
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
                          "Belum memiliki akun ?",
                          style: TextStyle(
                            color: Color(0xFFAFA1A1),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(APP_PAGE.register.toName);
                          },
                          child: const Text(
                            "Register",
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
      ),
    );
  }
}
