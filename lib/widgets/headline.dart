import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.name,
    required this.endindent,
  }) : super(key: key);
  final String name;
  final double endindent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.displayLarge
          ),
          Divider(
            thickness: 3.8,
            endIndent: endindent,
            indent: 6,
          )
        ],
      ),
    );
  }
}
