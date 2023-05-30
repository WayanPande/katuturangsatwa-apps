import 'package:flutter/material.dart';

class CharaterPill extends StatelessWidget {
  const CharaterPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton.tonal(
          onPressed: () {},
          child: Text("Ni Bawange"),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
