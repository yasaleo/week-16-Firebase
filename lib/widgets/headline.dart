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
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 50,
              letterSpacing: 9
            ),
          ),
          Divider(
            thickness: 3.8,
            color: Colors.black,
            endIndent: endindent,
            indent: 6,
          )
        ],
      ),
    );
  }
}
