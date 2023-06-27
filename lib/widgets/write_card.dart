import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:provider/provider.dart';

import '../providers/stories.dart';
import '../service/http_service.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class WriteStoryCard extends StatelessWidget {
  final String title, img, author;
  final int id;

  const WriteStoryCard(
      {Key? key,
      required this.title,
      required this.img,
      required this.author,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.pushNamed(APP_PAGE.storyInput.toName,
                queryParameters: {"id": id.toString()});
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        dotenv.env['IMG_URL']! + img,
                      ),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        PopupMenuButton<SampleItem>(
                          padding: EdgeInsets.zero,
                          onSelected: (SampleItem item) {
                            if (item == SampleItem.itemOne) {
                              context.pushNamed(APP_PAGE.storyDetail.toName,
                                  pathParameters: {"id": id.toString()});
                            }
                            if (item == SampleItem.itemTwo) {
                              HttpService()
                                  .deleteStory(id.toString())
                                  .then((value) => {
                                        if (value == 200)
                                          {
                                            Future.delayed(Duration.zero)
                                                .then((_) {
                                              Provider.of<Stories>(context,
                                                      listen: false)
                                                  .getStoriesWriter();
                                            }),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  SnackBar(
                                                    content: WillPopScope(
                                                      onWillPop: () async {
                                                        return true;
                                                      },
                                                      child: const Text(
                                                          'Story successfully deleted!'),
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 2000),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
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
                                                          'Fail to delete story!'),
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 2000),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                )
                                                .closed
                                                .then((value) => context.pop())
                                          }
                                      });
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemOne,
                              child: Text('View as Reader'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemTwo,
                              child: Text('Delete'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
