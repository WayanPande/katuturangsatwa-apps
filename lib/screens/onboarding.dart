import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/AppRouter.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).primaryColorLight,
                  //     borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(150),
                  //       bottomRight: Radius.circular(150),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 10,
                    left: -80,
                    right: -80,
                    child: Image.asset('assets/images/bg.png'),
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColorLight,
                      ),
                      child:  Icon(
                        Icons.menu_book_rounded,
                        size: 50,
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              "Katuturang Satwa",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                appService.onboarding = true;
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Get Started for free",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      )
    );
  }
}
