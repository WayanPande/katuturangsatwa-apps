import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:katuturangsatwa/screens/redirect_login.dart';
import 'package:katuturangsatwa/widgets/category_card.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:katuturangsatwa/service/http_service.dart';

import '../config/AppRouter.dart';
import '../providers/stories.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  bool _isLoading = false;
  bool _isLoadingCat = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getCategories().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
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
          title: const Text(
            "Are you sure want do this?",
          ),
          content: Wrap(
            children: [
              Column(
                children: [
                  const Text(
                      "The process of making the categories will take some times."),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _isLoadingCat = true;
                          });
                          HttpService().createCategory().then((value) => {
                                setState(() {
                                  _isLoadingCat = false;
                                }),
                                myAlert2()
                              });
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void myAlert2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            "Category Successfully Created.",
          ),
          content: Wrap(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  )
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
    final appService = Provider.of<AppService>(context);
    final categories = Provider.of<Stories>(context).categoryList;

    if (_isLoadingCat) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }

    return !appService.loginState
        ? const RedirectLogin()
        : LoaderOverlay(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Admin"),
              ),
              body: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration.zero).then((_) {
                    Provider.of<Stories>(context, listen: false)
                        .getCategories();
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text("Create category"),
                        onTap: () {
                          myAlert();
                        },
                        leading: const Icon(Icons.note_add),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Category List",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      _isLoading
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(50),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              child: categories.isNotEmpty
                                  ? Column(
                                      children: List.generate(
                                        categories.length,
                                        (index) {
                                          return CategoryCard(
                                            title: categories[index].name ??
                                                "katuturangsatwa",
                                            img: categories[index].gambar!,
                                            id: categories[index].id!,
                                          );
                                        },
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        const Center(
                                          child: Text("no data"),
                                        ),
                                        ListView(),
                                      ],
                                    ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
