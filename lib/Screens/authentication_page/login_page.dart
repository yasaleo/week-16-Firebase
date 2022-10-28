import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_week_16/Screens/home_page.dart';
import 'package:firebase_week_16/Screens/authentication_page/signin_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_inputfeild.dart';
import '../../widgets/headline.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Headline(
                  name: "Login ",
                  endindent: 180,
                ),
                const Spacer(
                  flex: 2,
                ),
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
                const SizedBox(
                  height: 20,
                ),
                CustomInputFeild(
                  controller: password,
                  hint: "Password",
                  obscureText: true,
                  widget: const Icon(
                    Icons.key_rounded,
                  ),
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
                const Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have a account yet! 🤷,  ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          maximumSize: const Size(70, 29),
                          minimumSize: const Size(70, 29),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          )),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(
                  flex: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () {
                    logIn(email.text.trim(), password.text.trim(), context);
                  },
                  child: const Text(
                    'Login ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logIn(String email, String password, BuildContext context) async {
    if (formkey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    content: const Text(
                      'Login Successfully  🥳 😃',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                  ),
                ),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  Homepage(),
                  ),
                )
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
              side: const BorderSide(color: Colors.red, width: 2.5),
            ),
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          ),
        );
      });
    }
  }
}
