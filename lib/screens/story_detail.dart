import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/widgets/character_pill.dart';

class StoryDetail extends StatefulWidget {
  final String id;

  const StoryDetail({Key? key, required this.id}) : super(key: key);

  @override
  _StoryDetailState createState() {
    return _StoryDetailState();
  }
}

class _StoryDetailState extends State<StoryDetail> {
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
                  context.pushNamed(APP_PAGE.reader.toName, pathParameters: {"id": widget.id});
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    widget.id,
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
                    "Wayan Pande",
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
                      'https://katuturangsatwa.com/static/image/satwa_cover/2c801cc3a49d4f44a6bc8c8c6ec12c71.jpg',
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
                children: List.generate(10, (index) {
                  return const CharaterPill();
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
              "solah ni bawang ajaka ni kesuna matungkasan pesan, tan bina cara yeh masanding teken apine. ni kesuna anak bobab, male megae, duweg pesan ngae pisuna, ento makrana memene stata ngugu pisadun ni kesuna ane ngorahang ni bawang ngumbang di tukade ngenemin anak truna. krana ngugu munyin ni kesuna, ditu ni bawang lantas tigtiga, siama aji yeh anget tur tundena magedi. disubane orahina teken ni bawang, ditu laut ni kesuna metu kenehne ane kaliwat loba. krana ento, lantas ni kesuna ngorahin memenne nigtig ukudane apang kanti babak belur. neked jumah ditu lantas gumatat-gumitite ento ane mencanen ni kesuna kanti ngemasin mati.",
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
