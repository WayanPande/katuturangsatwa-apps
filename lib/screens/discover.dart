import 'package:flutter/material.dart';
import 'package:flutter_sticky_widgets/flutter_sticky_widgets.dart';

import '../widgets/dashboard_card.dart';
import '../widgets/tag_card.dart';
import 'dashboard.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                        onFieldSubmitted: (value) {},
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
                                    25,
                                    (index) => TagCard(
                                      key: Key("tagCard-$index"),
                                      id: index,
                                      label: "Kategori $index",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                      children: List.generate(
                        imgList.length,
                            (index) {
                          return DashboardStoryCard(
                            title: imgList[index].title,
                            img: imgList[index].img,
                          );
                        },
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
