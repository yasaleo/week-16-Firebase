import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_week_16/widgets/constants.dart';
import 'package:firebase_week_16/widgets/custom_inputfeild.dart';
import 'package:firebase_week_16/widgets/headline.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final auth = FirebaseAuth.instance;

  final formkey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmpassword = TextEditingController();

  // final TextEditingController name = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  File? image;
  // final userid = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  cheight30,
                  cheight10,
                  const Headline(
                    name: "Register ",
                    endindent: 83,
                  ),
                  cheight30,
                  image == null
                      ? GestureDetector(
                          onTap: () {
                            pickimage();
                            
                          },
                          child: const CircleAvatar(
                            maxRadius: 70,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.person_add,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          maxRadius: 70,
                          backgroundImage: FileImage(image!),
                        ),
                  cheight30,
                  cheight20,
                  CustomInputFeild(
                    controller: email,
                    hint: "Email",
                    obscureText: false,
                    widget: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a your email 🤦';
                      }

                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Please enter a valid email 🙆";
                      }
                      return null;
                    },
                  ),
                  cheight20,
                  CustomInputFeild(
                    controller: password,
                    hint: "Password",
                    obscureText: true,
                    widget: const Icon(Icons.key),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter a your password 🤦';
                      }
                      if (value.length < 6) {
                        return "password should contain atleast 6 letters 💪";
                      }

                      return null;
                    },
                  ),
                  cheight20,
                  CustomInputFeild(
                    controller: confirmpassword,
                    hint: "Confirm Password",
                    obscureText: true,
                    widget: const Icon(Icons.key),
                    validator: (value) {
                      if (password.text.trim() != confirmpassword.text.trim()) {
                        return "password doesn't match 🙅";
                      }
                      if (value!.isEmpty) {
                        return 'please enter a your password 🤦';
                      }

                      return null;
                    },
                  ),
                  cheight30,
                  cheight20,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: () {
                      registeruser(
                          email.text.trim(), password.text.trim(), context);
                          uploadimage(email.text.trim());
                    },
                    child: const Text(
                      'Sign in ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registeruser(String email, String password, BuildContext context) async {
    if (formkey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    content: const Text(
                      'Created Successfully  🥳 🙋',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 15),
                  ),
                ),
                Navigator.of(context).pop()
              })
          .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.horizontal,
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      });
    }
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

  Future uploadimage(String? userid) async {
    FirebaseStorage.instance.ref().child('$userid/images').putFile(image!);
  }
}
