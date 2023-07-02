import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katuturangsatwa/service/http_service.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/users.dart';

class ProfileUpdate extends StatefulWidget {
  ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() {
    return _ProfileUpdateState();
  }
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  bool isPassShown = false;
  bool reIsPassShown = false;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //show popup dialog
  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            (image == null) ? 'Choose Media to Select' : 'Edit Media',
          ),
          content: Wrap(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.image),
                        const SizedBox(
                          width: 10,
                        ),
                        Text((image == null)
                            ? 'Take From Gallery'
                            : 'Replace From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera),
                        const SizedBox(
                          width: 10,
                        ),
                        Text((image == null)
                            ? 'Take From Camera'
                            : 'Replace From Camera'),
                      ],
                    ),
                  ),
                  image != null
                      ? ElevatedButton(
                          //if user click this button. user can upload image from camera
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              image = null;
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Remove Image"),
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).user;
    username.text = user?.username ?? "";
    name.text = user?.nama ?? "";
    email.text = user?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: InkWell(
                  onTap: () {
                    myAlert();
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 3,
                              color: Theme.of(context).primaryColorLight),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(40),
                            child: image == null
                                ? Image.network(
                                    dotenv.env['PROFILE_IMG_URL']! +
                                        (user?.gambar ?? ""),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile Picture",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Tap to change",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: username,
                      enabled: false,
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
                      enabled: false,
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
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                HttpService()
                                    .updateUser(
                                  UpdateProfile(
                                      id: (user?.id ?? "").toString(),
                                      name: name.text,
                                      img_update: image != null
                                          ? File(image!.path)
                                          : null),
                                )
                                    .then((value) {
                                  if (value == 200) {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext contextAlert) =>
                                          AlertDialog(
                                        title: const Center(
                                          child:
                                              Text('User Successfuly Updated'),
                                        ),
                                        actions: <Widget>[
                                          Center(
                                            child: FilledButton(
                                              onPressed: () {
                                                Future.delayed(Duration.zero)
                                                    .then((_) {
                                                  Provider.of<Users>(context,
                                                          listen: false)
                                                      .getUserData();
                                                });
                                                Navigator.pop(
                                                    contextAlert, 'OK');
                                                context.pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext contextAlert) =>
                                          AlertDialog(
                                        title:
                                            const Text('Fail to update user'),
                                        content: const Text("Please try again"),
                                        actions: <Widget>[
                                          Center(
                                            child: FilledButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    contextAlert, 'OK');
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
                              "Update",
                            ),
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
