import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_week_16/Screens/authentication_page/login_page.dart';
import 'package:firebase_week_16/personmodel/model.dart';
import 'package:firebase_week_16/widgets/constants.dart';

import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import 'add_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final auth = FirebaseAuth.instance;

  String? downloadurl;
  @override
  void initState() {
    getimage(auth.currentUser!.email.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CustomAppBar(
            leading: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Column(
                            children: [
                              cheight20,
                              downloadurl == null
                                  ? const CircleAvatar(
                                      maxRadius: 40,
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                    )
                                  : CircleAvatar(
                                    maxRadius: 55,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                        maxRadius: 50,
                                        backgroundColor: Colors.black,
                                        backgroundImage:
                                            NetworkImage(downloadurl!),
                                      ),
                                  ),
                              cheight20,
                              const Text(
                                "Signed in as",
                                style: TextStyle(fontSize: 20),
                              ),
                              cheight10,
                              Text(
                                auth.currentUser!.email.toString(),
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              cheight30,
                              ElevatedButton.icon(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                      (route) => false);
                                },
                                icon: const Icon(Icons.logout_rounded),
                                label: const Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.person)),
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
        body: SafeArea(
            child: StreamBuilder<List<PersonModel>>(
          stream: readpersons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final person = snapshot.requireData;
              return person.isEmpty
                  ? const Center(
                      child: Text(
                        "No Persons Added 😓",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 10,left: 10,bottom: 3),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text(person[index].name.toString()),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddScreen(
                                    address: person[index].address,
                                    name: person[index].name,
                                    age: person[index].age,
                                    uid: person[index].uid,
                                  ),
                                ));
                              },
                              trailing: IconButton(
                                onPressed: () {
                                  deleteperson(person[index].uid);
                                },
                                icon: const Icon(Icons.delete_forever_outlined),
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.black,
                            thickness: 2,
                            indent: 30,
                            endIndent: 30,
                          );
                        },
                        itemCount: person.length),
                  );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 5,
                ),
              );
            }
          },
        )));
  }

  Stream<List<PersonModel>> readpersons() => FirebaseFirestore.instance
      .collection(auth.currentUser!.email.toString())
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => PersonModel.fromMap(doc.data())).toList());

  Future getimage(String? userid) async {
    final urll = await FirebaseStorage.instance
        .ref()
        .child("$userid/images")
        .getDownloadURL();
    downloadurl = urll;
  }

  Future deleteperson(String? uid) async {
    await FirebaseFirestore.instance
        .collection(auth.currentUser!.email.toString())
        .doc(uid)
        .delete();
  }
}
