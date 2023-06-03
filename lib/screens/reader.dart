import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Reader extends StatefulWidget {
  final String id;

  const Reader({Key? key, required this.id}) : super(key: key);

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
                  widget.id,
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
                      "Ada tuturan satua anak makurenan, ngelah koné pianak luh-luh duang diri. Pianakné ané kelihan madan Ni Bawang, ané cerikan madan Ni Kesuna. Akurenan ngoyong koné di désa. Sewai-wai geginané tuah maburuh kauma. Pianakné dua ento matungkasan pesan solahné. Tan bina cara gumi tekén langit. Solah Ni Bawang ajaka Ni Kesuna matungkasan pesan, tan bina cara yeh masanding tekén apiné. Ni Bawang anak jemet, duweg megaé nulungin reramané. Duweg masih ia ngraos, sing taen né madan ngraos ané jelek-jelek. Jemet melajang raga, apa-apa ané dadi tugasné dadi anak luh. Marengin memé megarapan di paon, metanding canang, sing taen leb tekén ajah-ajahan agamané. Melénan pesan ngajak nyamané, Ni Kesuna. Ni Kesuna anak bobab, malé megaé, duweg pesan ngaé pisuna, ento makrana méméné stata ngugu pisadun Ni Kesuna ané ngorahang Ni Bawang ngumbang di tukadé ngenemin anak truna. Sedek dina anu, dugasé ento sujatiné, Ni Bawang mara suug nglesung padi laut kayeh sambilanga ngaba jun anggon ngalih yeh. Krana ngugu munyin Ni Kesuna, ditu Ni Bawang lantas tigtiga, siama aji yeh anget tur tundena magedi. Ni Bawang laut megedi sambilangé ngeling sigsigan. Di subané ngutang umah, neked koné yé di tukadé ketemu ajak kedis crukcuk kuning. Ditu, Kedis Crukcuk Kuningé kapilasa tekén unduk Ni Bawangé. Ni Bawang gotola, baanga emas-emasan, marupa pupuk, subeng, kalung, bungkung, gelang, muah kain sutra. Sesukat Ni Bawang ngelah panganggi ané melah-melah buka keto, ia nongos di umah dadongné.  Tusing taen yé mulih ké umah reramané. Kacrita jani Ni Kesuna koné nepukin embokné mapanganggo melah-melah, laut ia nakonang uli dija maan panganggo buka keto. Disubané orahina tekén Ni Bawang, ditu laut Ni Kesuna metu kenehné ané kaliwat loba. Edot ngelahang penganggo miwah priasan ané bungah buka ané gelahang embokné. Krana ento, lantas Ni Kesuna ngorahin méménné nigtig ukudané apang kanti babak belur. Sesubané katigtig, lantas ia ngeling sengu-sengu ka tukadé katemu tekén I Kedis Crukcuk Kuning. Kacrita jani, I Crukcuk Kuning ngotol ukudan Ni Kesunané, isinina gumatat-gumitit. Neked jumah ditu lantas gumatat-gumitité ento ané mencanen Ni Kesuna kanti ngemasin mati. Kéto suba upah anak ané mrekak, setata demen mapisuna timpal, sinah muponin pala karma ané tan rahayu. hs",
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
