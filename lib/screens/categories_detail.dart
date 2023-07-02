import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/stories.dart';
import '../util/data_class.dart';
import '../widgets/dashboard_card.dart';

class CategoriesDetail extends StatefulWidget {
  final String id, title;

  const CategoriesDetail({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _CategoriesDetailState createState() {
    return _CategoriesDetailState();
  }
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  List<Story> _storyList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false)
          .getStoriesPerCategory(widget.id)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
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
            _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: _storyList.isNotEmpty
                        ? Column(
                            children: List.generate(
                              _storyList.length,
                              (index) {
                                return DashboardStoryCard(
                                  title: _storyList[index].judul ??
                                      "katuturangsatwa",
                                  img: _storyList[index].gambar!,
                                  author: _storyList[index].author ??
                                      "katuturangsatwa",
                                  id: _storyList[index].id!,
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text("no data"),
                          ),
                  )
          ],
        ),
      ),
    );
  }
}
