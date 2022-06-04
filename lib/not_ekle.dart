import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/notlar.dart';

class NotEkle extends StatefulWidget {
  const NotEkle({Key? key}) : super(key: key);

  @override
  State<NotEkle> createState() => _NotEkleState();
}

class _NotEkleState extends State<NotEkle> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController not = TextEditingController();
  final authUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    CollectionReference booksRef = _firestore
        .collection('users')
        .doc(authUser!.email)
        .collection('notlar');
    return Scaffold(
        appBar: AppBar(
          title: const Text('NOTLARIM', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: not,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "Not giriniz.",
                      labelStyle: TextStyle(
                        color: (Color.fromARGB(255, 23, 87, 25)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 23, 87, 25)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Not giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: (() {
                      Map<String, dynamic> kitapData = {
                        'not': not.text,
                      };
                      booksRef.doc(not.text).set(kitapData);

                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Notlar()));
                    }),
                    child: const Text(
                      "Kaydet",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 162, 199)),
                    ),
                    style: TextButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 0, 162, 199)),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
