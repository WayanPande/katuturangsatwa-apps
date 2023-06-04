import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Reader extends StatefulWidget {
  final String text, title;

  const Reader({Key? key, required this.text, required this.title}) : super(key: key);

  @override
  _ReaderState createState() {
    return _ReaderState();
  }
}

class _ReaderState extends State<Reader> {
  final ScrollController _scrollViewController = ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;
  Color? _bgColor;
  Color _textColor = Colors.black;
  double _fontSize = 17;

  @override
  void initState() {
    super.initState();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            _showAppbar = false;
          });
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            _showAppbar = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 60.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AppBar(
                title: Text(
                  widget.title,
                ),
                backgroundColor: _bgColor ?? Theme.of(context).canvasColor,
                foregroundColor: _textColor,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _bgColor = Theme.of(context).canvasColor;
                                          _textColor = Colors.black;
                                          _fontSize = 17;
                                        });
                                      },
                                      child: const Text("Reset"),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Page Color",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _bgColor = Theme.of(context).canvasColor;
                                                    _textColor = Colors.black;
                                                  });
                                                },
                                                child: const Text("light"),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: FilledButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _bgColor = Colors.black87;
                                                    _textColor = Colors.white70;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                ),
                                                child: const Text("dark"),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: FilledButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _bgColor =
                                                        Colors.yellow.shade50;
                                                    _textColor = Colors.brown;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .yellow.shade50),
                                                ),
                                                child: const Text(
                                                  "dim",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Font size",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_fontSize > 12) {
                                                      _fontSize -= 1;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.text_decrease,
                                                  color: Colors.grey.shade200,
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black45),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if ((_fontSize < 25)) {
                                                      _fontSize += 1;
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.text_increase,
                                                  color: Colors.grey.shade200,
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black45),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                ],
                centerTitle: true,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAppbar = !_showAppbar;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _bgColor ?? Theme.of(context).canvasColor,
                    ),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: _textColor,
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
