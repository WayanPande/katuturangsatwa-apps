import 'package:flutter/material.dart';

class CategoriesDetail extends StatefulWidget {
  final String id;
  const CategoriesDetail({Key? key, required this.id}) : super(key: key);

  @override
  _CategoriesDetailState createState() {
    return _CategoriesDetailState();
  }
}

class _CategoriesDetailState extends State<CategoriesDetail> {
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
        title: Text("${widget.id}"),
      ),
      body: Text("categories"),
    );
  }
}
