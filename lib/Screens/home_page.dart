import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_week_16/firebse/firebase_ops.dart';
import 'package:firebase_week_16/model/model.dart';
import 'package:firebase_week_16/widgets/custom_drawer.dart';

import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/show_snackbar.dart';
import 'add_screen.dart';
import 'authentication_page/login_page.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        key: _scaffoldKey,
        appBar: CustomAppBar(
            leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu)),
            title: "Home ",
            widget: MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
              child: Row(
                children: [
                  const Icon(Icons.logout_rounded),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "LogOut",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            )),
        endDrawer: Container(
          height: 300,
          width: 300,
          color: Colors.white,
        ),
        body: SafeArea(
            child: StreamBuilder<List<PersonModel>>(
          stream: FirebaseOperations().readpersons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final person = snapshot.requireData;
              return person.isEmpty
                  ? Center(
                      child: Text(
                        "Nothing to see here 😓",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 3),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                leading: const Text(
                                  'Name :',
                                  style: TextStyle(fontSize: 19.9),
                                ),
                                title: Text(
                                  person[index].name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22),
                                ),
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
                                    FirebaseOperations().deleteperson(
                                        uid: person[index].uid,
                                        context: context);
                                    ShowSnackbar(
                                        context: context, msg: "Deleted 👋 🪦");
                                  },
                                  icon:
                                      const Icon(Icons.delete_forever_outlined),
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.black45,
                              thickness: 2,
                              indent: 30,
                              endIndent: 30,
                            );
                          },
                          itemCount: person.length),
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  strokeWidth: 10,
                ),
              );
            }
          },
        )));
  }

  Future getimage(String? userid) async {
    final urll = await FirebaseStorage.instance
        .ref()
        .child("$userid/images")
        .getDownloadURL();
    downloadurl = urll;
  }
}
