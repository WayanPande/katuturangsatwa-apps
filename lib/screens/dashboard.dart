import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:katuturangsatwa/router/route_utils.dart';
import 'package:katuturangsatwa/widgets/dashboard_card.dart';
import 'package:katuturangsatwa/widgets/dashboard_carousel.dart';

final List<CarouselProps> imgList = [
  CarouselProps(
      img:
          'https://katuturangsatwa.com/static/image/satwa_cover/2c801cc3a49d4f44a6bc8c8c6ec12c71.jpg',
      title: "Ni Bawang lan ni kesuna kesini kesono",
      author: "Wayan Pande"),
  CarouselProps(
      img:
          'https://katuturangsatwa.com/static/image/satwa_cover/3ca4c6d3cd194f79bf442bd4f598ec76.jpg',
      title: "Kambing Takutin Macan",
      author: "Jose"),
  CarouselProps(
      img:
          'https://katuturangsatwa.com/static/image/satwa_cover/f3d44ea91ced49c3930709e5a4676795.jpeg',
      title: "Siap Selem",
      author: "I Siap Seleme"),
  CarouselProps(
      img:
          'https://katuturangsatwa.com/static/image/satwa_cover/c4a4e2d6315c48b397d808cd7f621b9c.jpg',
      title: "Cupak Grantang",
      author: "I Made"),
  CarouselProps(
      img:
          'https://katuturangsatwa.com/static/image/satwa_cover/67ef11398b9e4f8e87486515a02c55b9.jpg',
      title: "Ayam Sangkur",
      author: "Wayan Pande Putra"),
  CarouselProps(
      img:
          'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      title: "Timun Mas",
      author: "Ariyana made")
];

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
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
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Latest story",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        context.goNamed(APP_PAGE.discover.toName);
                      },
                      child: Text("View all"),
                    ),
                  ],
                ),
              ),
              DashboardCarousel(data: imgList),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommendation",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        context.goNamed(APP_PAGE.discover.toName);
                      },
                      child: Text("View all"),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
