// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:firebase_week_16/widgets/custom_paginated_datable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../firebse/firebase_ops.dart';
import '../widgets/constants.dart';
import '../widgets/custom_inputfeild.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key, this.name, this.age, this.address, this.uid});

  String? name;
  final int? age;
  final String? address;
  final String? uid;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController name = TextEditingController();

  final TextEditingController age = TextEditingController();

  final TextEditingController address = TextEditingController();

  final auth = FirebaseAuth.instance;

  File? image;

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
              // widget.uid == null
              //     ? FirebaseOperations().uploadperson(
              //         context: context,
              //         address: address.text,
              //         age: age.text,
              //         name: name.text,
              //       )
              //     : FirebaseOperations().updateperson(
              //         context: context,
              //         address: address.text,
              //         age: age.text,
              //         name: name.text,
              //         uid: widget.uid!,
              //       );
              if (image != null) {
              final bs64=  base64Encode(image!.readAsBytesSync());
                print(bs64);
              }
            },
            child:
                Text("👍 Submit", style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                image == null
                    ? GestureDetector(
                        onTap: () {
                          pickimage();
                        },
                        child: CircleAvatar(
                          maxRadius: 70,
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          child: const Icon(
                            Icons.person_add,
                            size: 60,
                          ),
                        ),
                      )
                    : Material(
                        elevation: 10,
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 5,
                          ),
                        ),
                        child: CircleAvatar(
                          maxRadius: 70,
                          backgroundImage: FileImage(image!),
                        ),
                      ),
                cheight30,
                CustomInputFeild(
                  controller: name,
                  labell: const Text(
                    "Name",
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
                  ),
                  widget: const Text(
                    "🏡",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                cheight20,
                // const SortingDataTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickimage() async {
    final imagepath =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepath == null) {
      return;
    } else {
      final img = File(imagepath.path);
      setState(() {
        image = img;
      });
    }
  }
}
