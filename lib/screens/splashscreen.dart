import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/AppRouter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppService _appService;

  @override
  void initState() {
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();
    super.initState();
  }

  void onStartUp() async {
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
