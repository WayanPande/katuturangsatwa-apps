import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/screens/redirect_login.dart';
import 'package:katuturangsatwa/widgets/category_card.dart';
import 'package:katuturangsatwa/widgets/write_card.dart';
import 'package:provider/provider.dart';

import '../config/AppRouter.dart';
import '../providers/stories.dart';
import '../widgets/dashboard_card.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  bool _showFab = false;
  bool _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    const duration = Duration(milliseconds: 300);
    final categories = Provider.of<Stories>(context).categoryList;

    return !appService.loginState
        ? const RedirectLogin()
        : Scaffold(
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
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  setState(() {
                    if (direction == ScrollDirection.reverse) {
                      _showFab = true;
                    } else if (notification.metrics.pixels == 0) {
                      _showFab = false;
                    }
                  });
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text("Create category"),
                        onTap: () {
                          context.pushNamed(APP_PAGE.storyInput.toName);
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
