import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:katuturangsatwa/service/http_service.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';

class StoryInput extends StatefulWidget {
  StoryInput({Key? key}) : super(key: key);

  @override
  _StoryInputState createState() {
    return _StoryInputState();
  }
}

class _StoryInputState extends State<StoryInput> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  XFile? image;
  final _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    Provider.of<Users>(context, listen: false).getUserData();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Write your story"),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && user != null) {
                HttpService()
                    .registerStory(RegisterStory(
                        judul_satwa: title.text,
                        text_satwa: desc.text,
                        penulis_satwa: user.id.toString(),
                        img_satwa: File(image!.path)))
                    .then((value) => {
                          if (value == 200)
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    SnackBar(
                                      content: WillPopScope(
                                        onWillPop: () async {
                                          return true;
                                        },
                                        child: const Text(
                                            'Success adding new story!'),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 1700),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )
                                  .closed
                                  .then((value) => context.pop())
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    SnackBar(
                                      content: WillPopScope(
                                        onWillPop: () async {
                                          return true;
                                        },
                                        child: const Text(
                                            'Fail adding new story!'),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  )
                                  .closed
                                  .then((value) => context.pop())
                            }
                        });
              }
            },
            child: const Text("PUBLISH"),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  myAlert();
                },
                child: image != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              //to show image, you type like this.
                              File(image!.path),
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                            ),
                            Positioned(
                              right: 10,
                              bottom: 20,
                              child: IconButton(
                                onPressed: () {
                                  myAlert();
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black87)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : DottedBorder(
                        radius: const Radius.circular(10),
                        color: Colors.black,
                        strokeWidth: 1,
                        dashPattern: const [
                          5,
                          5,
                        ],
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: const Column(
                            children: [
                              Icon(Icons.image_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Tap to add cover"),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Story Title",
                    ),
                    controller: title,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Story Title cannot be empty";
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Tap here to start writing",
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    controller: desc,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Story Description cannot be empty";
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
