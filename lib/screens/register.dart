import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/service/http_service.dart';
import 'package:katuturangsatwa/util/data_class.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  bool isPassShown = false;
  bool reIsPassShown = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Name cannot be empty";
                          }
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Email cannot be empty";
                          }

                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Wrong email format";
                          }
                        }
                        return null;
                      },
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
                    TextFormField(
                      controller: repassword,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "RePassword cannot be empty";
                          }

                          if (value != password.text) {
                            return "RePassword not the same as password";
                          }
                        }
                        return null;
                      },
                      obscureText: !reIsPassShown,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Re-Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              reIsPassShown = !reIsPassShown;
                            });
                          },
                          icon: Icon(
                            reIsPassShown
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
                          child: FilledButton.tonal(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                HttpService()
                                    .registerUser(
                                  RegisterData(
                                      username: username.text,
                                      password: password.text,
                                      email: email.text,
                                      name: name.text),
                                )
                                    .then((value) {
                                  if (value["code"] == 200) {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext contextAlert) => AlertDialog(
                                        title: const Text('User Successfuly Created'),
                                        actions: <Widget>[
                                          Center(
                                            child: FilledButton(
                                              onPressed: () {
                                                Navigator.pop(contextAlert, 'OK');
                                                context.pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }else{
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext contextAlert) => AlertDialog(
                                        title: const Text('Fail to create user'),
                                        content: Text(value["error"] ?? "Please try again"),
                                        actions: <Widget>[
                                          Center(
                                            child: FilledButton(
                                              onPressed: () {
                                                Navigator.pop(contextAlert, 'OK');
                                              },
                                              child: const Text('OK'),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                });
                              }
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
                            context.pop();
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
      ),
    );
  }
}
