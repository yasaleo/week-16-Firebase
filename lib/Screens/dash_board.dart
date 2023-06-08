import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        islead: true,
        title: "DashBoard",
      ),
      body: Center(
        child: Text(
          "This is DashBoard",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
