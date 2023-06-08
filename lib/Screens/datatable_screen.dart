import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';
import '../widgets/custom_paginated_datable.dart';

class DataTableScreen extends StatelessWidget {
  const DataTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Paginated Data Table",
        islead: true,
      ),
      body: Column(
        children: const [
          cheight20,
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomPaginatedDataTAble(),
          ),
        ],
      ),
    );
  }
}
