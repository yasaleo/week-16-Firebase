import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.widget,
    this.islead = false,
  }) : super(key: key);
  final String title;
  final Widget widget;
  final bool islead;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: islead,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 5,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      actions: [
        widget,
      ],
    );
  }
}
