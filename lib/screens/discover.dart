import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:katuturangsatwa/service/http_service.dart';
import 'package:katuturangsatwa/util/data_class.dart';
import 'package:provider/provider.dart';

import '../providers/stories.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/tag_card.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() {
    return _DiscoverState();
  }
}

class _DiscoverState extends State<Discover> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focus = FocusNode();
  static const _pageSize = 20;
  List<Categories> _categoriesList = [];

  final PagingController<int, Story> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Stories>(context, listen: false).getCategories();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _focus.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await HttpService().getStoriesPaginate(_pageSize, pageKey, _searchController.text);
      var finalData = newItems.map((e) => Story.fromJson(e)).toList();
      final isLastPage = finalData.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(finalData);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(finalData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    var story = Provider.of<Stories>(context);
    _categoriesList = story.categoryList;

    return Scaffold(
      body: StickyContainer(
        displayOverFlowContent: false,
        stickyChildren: [
          StickyWidget(
            initialPosition: StickyPosition(top: 60, right: 0),
            finalPosition: StickyPosition(top: 0, right: 0),
            controller: _controller,
            child: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 12,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: (value) {
                          _pagingController.refresh();
                        },
                        onTap: () {
                          setState(() => {});
                        },
                        textInputAction: TextInputAction.search,
                        focusNode: _focus,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                width: 0.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Cari cerita",
                          fillColor: Theme.of(context).canvasColor,
                          contentPadding: EdgeInsets.zero,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _focus.hasFocus
                          ? TextButton(
                              key: const Key("clearBtn"),
                              onPressed: () {
                                _focus.unfocus();
                                _searchController.clear();
                                _pagingController.refresh();
                                setState(() => {});
                              },
                              child: const Text("Cancel"),
                            )
                          : const SizedBox(
                              key: Key("normal"),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _controller,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: const Text("Discover"),
                    surfaceTintColor: Colors.transparent,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInCirc,
                    switchOutCurve: Curves.easeOutCirc,
                    child: !_focus.hasFocus
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Browse tags",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3,
                                  children: List.generate(
                                    _categoriesList.length,
                                    (index) => TagCard(
                                      key: Key("tagCard-$index"),
                                      id: _categoriesList[index].id!,
                                      label: _categoriesList[index].name ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : PagedListView<int, Story>(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            pagingController: _pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Story>(
                              itemBuilder: (context, item, index) =>
                                  DashboardStoryCard(
                                title: item.judul ?? "",
                                author: item.author ?? "",
                                id: item.id!,
                                img: item.gambar ?? "",
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
