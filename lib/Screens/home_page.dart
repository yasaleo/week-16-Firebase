import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/personmodel/model.dart';
import 'package:firebase_week_16/widgets/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import 'add_screen.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CustomAppBar(
            title: "Home ",
            widget: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddScreen(),
                  ),
                );
              },
              child: const Text(
                " 👉 Add ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(child: StreamBuilder<List<PersonModel>>(
          stream: readpersons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final person = snapshot.requireData;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(person[index].name.toString()),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return cheight20;
                  },
                  itemCount: person.length);
            } else {
              return cheight10;
            }
          },
        )));
  }

  Stream<List<PersonModel>> readpersons() => FirebaseFirestore.instance
      .collection(auth.currentUser!.email.toString())
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => PersonModel.fromMap(doc.data())).toList());
}
