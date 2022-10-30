import 'package:flutter/material.dart';

class ShowSnackbar {
  ShowSnackbar({required BuildContext context, required String msg}) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        content:  Text(
          msg,
          style:const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
