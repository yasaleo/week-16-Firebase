// ignore_for_file: use_build_context_synchronously



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/personmodel/model.dart';
import 'package:firebase_week_16/widgets/constants.dart';
import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_inputfeild.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key, this.name, this.age, this.address, this.uid});

  String? name;
  int? age;
  String? address;
  String? uid;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController name = TextEditingController();

  final TextEditingController age = TextEditingController();

  final TextEditingController address = TextEditingController();

  final auth = FirebaseAuth.instance;


  @override
  void initState() {
    name.text = widget.name ??= '';
    address.text = widget.address ?? '';
    if (widget.age == null) {
      age.text = '';
    } else {
      age.text = widget.age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: CustomAppBar(
          islead: true,
          title: "Person ",
          widget: TextButton(
            onPressed: () {
              widget.uid == null
                  ? uploadperson(context)
                  : updateperson(context);
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
    String uid = const Uuid().v4();

    PersonModel person = PersonModel();
    int agee = int.parse(age.text);

    person.name = name.text.trim();
    person.age = agee;
    person.uid = uid;
    person.address = address.text;
    await firestore
        .collection(
          auth.currentUser!.email.toString(),
        )
        .doc(uid)
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

  void updateperson(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    PersonModel updateper = PersonModel();
    updateper.name = name.text;
    updateper.address = address.text;
    updateper.age = int.parse(age.text);
    updateper.uid = widget.uid;

    await firestore
        .collection(
          auth.currentUser!.email.toString(),
        )
        .doc(widget.uid)
        .update(updateper.toMap());
    Navigator.of(context).pop();
  }


 
}
