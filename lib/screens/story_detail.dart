import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/widgets/character_pill.dart';
import 'package:provider/provider.dart';

import '../providers/stories.dart';

class StoryDetail extends StatefulWidget {
  final String id;

  const StoryDetail({Key? key, required this.id}) : super(key: key);

  @override
  _StoryDetailState createState() {
    return _StoryDetailState();
  }
}

class _StoryDetailState extends State<StoryDetail> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false)
          .getStoryDetail(int.parse(widget.id));
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var story = Provider.of<Stories>(context).storyDetail;
    List<String>? tokoh = story?.tokoh?.split(";");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Story Detail",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton.outlined(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(15),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: FilledButton.tonal(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_book_rounded),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Continue Reading",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  context.pushNamed(APP_PAGE.reader.toName,
                      queryParameters: {"text": story?.text ?? "", "title": story?.judul ?? ""});
                },
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          story?.judul ?? "",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          story?.author ?? "",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            dotenv.env['IMG_URL']! + (story?.gambar ?? ""),
                          ),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Character",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(tokoh?.length ?? 0, (index) {
                        return CharaterPill(
                          label: tokoh?[index] ?? "",
                          key: Key("tokoh-$index"),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    story?.ringkas ?? "",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
