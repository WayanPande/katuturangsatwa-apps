import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final String label;
  final int id;

  const TagCard({Key? key, required this.id, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Theme.of(context).primaryColor
          .withOpacity(0.2),
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
