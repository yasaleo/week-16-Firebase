// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/firebse/firebase_ops.dart';
import 'package:firebase_week_16/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

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
                  ? FirebaseOperations().uploadperson(
                      context: context,
                      address: address.text,
                      age: age.text,
                      name: name.text,
                    )
                  : FirebaseOperations().updateperson(
                      context: context,
                      address: address.text,
                      age: age.text,
                      name: name.text,
                      uid: widget.uid!,
                    );
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


}
