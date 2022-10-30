// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../personmodel/model.dart';
import '../widgets/constants.dart';

class FirebaseOperations {
  bool isloading = false;
  final auth = FirebaseAuth.instance;

  void uploadperson({
    required BuildContext context,
    required String age,
    required String address,
    required String name,
  }) async {
    loading(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = const Uuid().v4();

    PersonModel person = PersonModel();
    int agee = int.parse(age);

    person.name = name.trim();
    person.age = agee;
    person.uid = uid;
    person.address = address;
    await firestore
        .collection(
          auth.currentUser!.email.toString(),
        )
        .doc(uid)
        .set(
          person.toMap(),
        );
    isloading = false;
    Navigator.of(context)
      ..pop()
      ..pop();
    ShowSnackbar(context: context, msg: 'Added SucessFully 🥳');
  }

  void updateperson({
    required BuildContext context,
    required String name,
    required String address,
    required String age,
    required String uid,
  }) async {
    loading(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    PersonModel updateper = PersonModel();
    updateper.name = name;
    updateper.address = address;
    updateper.age = int.parse(age);
    updateper.uid = uid;

    await firestore
        .collection(
          auth.currentUser!.email.toString(),
        )
        .doc(uid)
        .update(updateper.toMap());

    Navigator.of(context)
      ..pop()
      ..pop();
    ShowSnackbar(context: context, msg: "Updated sucessfully 👍");
  }

  Stream<List<PersonModel>> readpersons() => FirebaseFirestore.instance
      .collection(auth.currentUser!.email.toString())
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => PersonModel.fromMap(doc.data())).toList());

  Future deleteperson(
      {required String? uid, required BuildContext context}) async {
    
    await FirebaseFirestore.instance
        .collection(auth.currentUser!.email.toString())
        .doc(uid)
        .delete();
   
  }
}
