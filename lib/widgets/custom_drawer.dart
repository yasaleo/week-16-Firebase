import 'package:firebase_week_16/Screens/sliver_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/add_screen.dart';
import '../Screens/dash_board.dart';
import '../Screens/datatable_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Menu",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          CustomDrawerChild(
            screen: const DashBoardScreen(),
            title: Text(
              "DashBoard",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: const Icon(Icons.dashboard_rounded),
          ),
          CustomDrawerChild(
            screen: AddScreen(),
            title: Text(
              " Add Details ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: const Icon(Icons.add_box_rounded),
          ),
          CustomDrawerChild(
            screen: const DataTableScreen(),
            title: Text(
              " Data Table ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: const Icon(Icons.table_chart_rounded),
          ),
          CustomDrawerChild(
            screen: SliverScreen(),
            title: Text(
              "Sliver Screen",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: const Icon(Icons.bubble_chart),
          )
        ],
      ),
    );
  }
}

class CustomDrawerChild extends StatelessWidget {
  CustomDrawerChild({
    super.key,
    required this.screen,
    required this.leading,
    required this.title,
  });
  Widget screen;
  Widget leading;
  Widget title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          ),
          leading: leading,
          title: title,
        ),
      ),
    );
  }
}
