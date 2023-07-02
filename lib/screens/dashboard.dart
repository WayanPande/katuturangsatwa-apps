import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/providers/stories.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:katuturangsatwa/widgets/dashboard_card.dart';
import 'package:katuturangsatwa/widgets/dashboard_carousel.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  List<Story> _storyList = [];
  List<Story> _storyListLatest = [];
  bool _isLoading = false;
  bool _isLoadingCarousel = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _isLoadingCarousel = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getStories().then((_) {
        setState(() {
          _isLoadingCarousel = false;
        });
      });
      Provider.of<Stories>(context, listen: false).getStoriesLatest().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var story = Provider.of<Stories>(context);
    _storyList = story.storyList;
    _storyListLatest = story.storyListLatest;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest story",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              _isLoadingCarousel
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : DashboardCarousel(data: _storyListLatest),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommendation",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
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
                          : const Text("no data"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
