import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zehra/gradient_box.dart';
import 'package:zehra/login.dart';
import 'package:zehra/main_menu.dart';
import 'package:zehra/siralama_buton.dart';
import 'package:zehra/updatepassword.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        const Text('Oturum kapalı');
      } else {
        Text('Oturum Açık ${user.email} ve email durumu ${user.emailVerified}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PROFİL', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.orange,
        ),
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (!snapshots.hasData) return Center();
                        final users = snapshots.data!.docs;
                        return Column(
                          children: [
                            Text("Email: ${users[0]['email']}",
                                style: TextStyle(fontSize: 20)),
                            Text("Score: ${users[0]['score'].toString()}",
                                style: TextStyle(fontSize: 20)),
                          ],
                        );
                      }),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: (() {
                    signOutUser();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }),
                  child: const Text(
                    "Oturumu Kapat",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                  ),
                  style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 0, 162, 199)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                /* TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdatePassword()));
                  }),
                  child: const Text(
                    "Şifre değiştir",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                  ),
                  style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 0, 162, 199)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ), */
                SizedBox(height: 30),
                SiralamaButon()
              ],
            ),
          ),
        ));
  }

  void signOutUser() async {
    await auth.signOut();
  }
}
