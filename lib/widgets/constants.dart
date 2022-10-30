import 'package:flutter/material.dart';

const cheight20 = SizedBox(height :20);
const cheight10 = SizedBox(height: 10);
const cheight30 = SizedBox(height: 30);

loading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black12,
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 7,
        ),
      );
    },
  );
}
