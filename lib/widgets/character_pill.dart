import 'package:flutter/material.dart';

class CharaterPill extends StatelessWidget {
  final String label;
  const CharaterPill({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton.tonal(
          onPressed: () {},
          child: Text(label),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
