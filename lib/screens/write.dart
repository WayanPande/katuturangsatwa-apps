import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/screens/redirect_login.dart';
import 'package:katuturangsatwa/widgets/write_card.dart';
import 'package:provider/provider.dart';

import '../config/AppRouter.dart';
import '../providers/stories.dart';
import '../widgets/dashboard_card.dart';

class Write extends StatefulWidget {
  Write({Key? key}) : super(key: key);

  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State<Write> {
  bool _showFab = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getStoriesWriter();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchPage() async {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getStoriesWriter();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    final story = Provider.of<Stories>(context).storyListWriter;
    const duration = Duration(milliseconds: 300);

    if (appService.loginState) {
      _fetchPage();
    }

    return !appService.loginState
        ? const RedirectLogin()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Write"),
            ),
            floatingActionButton: AnimatedSlide(
              duration: duration,
              offset: _showFab ? Offset.zero : const Offset(0, 2),
              child: AnimatedOpacity(
                duration: duration,
                opacity: _showFab ? 1 : 0,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    context.pushNamed(APP_PAGE.storyInput.toName);
                  },
                ),
              ),
            ),
            body: NotificationListener<UserScrollNotification>(
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
                      title: const Text("Create a new story"),
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
                        "My Story",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: List.generate(
                          story.length,
                          (index) {
                            return WriteStoryCard(
                              title: story[index].judul ?? "katuturangsatwa",
                              img: story[index].gambar!,
                              author: story[index].author ?? "katuturangsatwa",
                              id: story[index].id!,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
