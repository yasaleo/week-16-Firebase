// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/personmodel/model.dart';
import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_inputfeild.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController name = TextEditingController();

  final TextEditingController age = TextEditingController();

  final TextEditingController address = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: CustomAppBar(
          islead: true,
          title: "Add",
          widget: TextButton(
            onPressed: () {
              uploadperson(context);
            },
            child: const Text(
              "👍 Submit",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomInputFeild(
                  controller: name,
                  labell: const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  widget: const Text(
                    "👦",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputFeild(
                  controller: age,
                  labell: const Text(
                    "Age",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  widget: const Text(
                    "👀",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputFeild(
                  controller: address,
                  labell: const Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  widget: const Text(
                    "🏡",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadperson(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    PersonModel person = PersonModel();
    int agee = int.parse(age.text);
    
    person.name = name.text.trim();
    person.age = agee;
    person.uid = user!.uid;
    person.address = address.text;
    await firestore
        .collection(
          auth.currentUser!.email.toString(),
        )
        .doc()
        
        .set(
          person.toMap(),
        );
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        content: const Text(
          'Added SucessFully 🥳',
          style: TextStyle(color: Colors.white),
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
