import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() {
    return _DiscoverState();
  }
}

class _DiscoverState extends State<Discover> {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Discover"),

          ],
        ),
      ),
    );
  }
}