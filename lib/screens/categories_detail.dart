import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/stories.dart';
import '../util/data_class.dart';
import '../widgets/dashboard_card.dart';

class CategoriesDetail extends StatefulWidget {
  final String id, title;
  const CategoriesDetail({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  _CategoriesDetailState createState() {
    return _CategoriesDetailState();
  }
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  List<Story> _storyList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getStoriesPerCategory(widget.id);
    });
  }

  @override
  void dispose() {
    _storyList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var story = Provider.of<Stories>(context);
    _storyList = story.storyListCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: _storyList.isNotEmpty ? Column(
                children: List.generate(
                  _storyList.length,
                      (index) {
                    return DashboardStoryCard(
                      title: _storyList[index].judul ?? "katuturangsatwa",
                      img: _storyList[index].gambar!,
                      author: _storyList[index].author ?? "katuturangsatwa",
                      id: _storyList[index].id!,
                    );
                  },
                ),
              ) : const Text("no data"),
            )
          ],
        ),
      ),
    );
  }
}
