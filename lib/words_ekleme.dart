import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/words.dart';

class WordsEkleme extends StatefulWidget {
  const WordsEkleme({Key? key}) : super(key: key);

  @override
  State<WordsEkleme> createState() => _WordsEklemeState();
}

class _WordsEklemeState extends State<WordsEkleme> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController ingilizce = TextEditingController();
  TextEditingController turkce = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference booksRef = _firestore.collection('words');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kelime Ekle', style: TextStyle(fontSize: 20)),
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
                    controller: ingilizce,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "İngilizce ",
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
                        return "İngilizce kelime giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: turkce,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      labelText: "Türkçe",
                      labelStyle: TextStyle(
                        color: (Color.fromARGB(255, 23, 87, 25)),
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 4.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 23, 87, 25)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Türkçe kelime giriniz.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: (() {
                      Map<String, dynamic> kitapData = {
                        'word': ingilizce.text,
                        'mean': turkce.text,
                      };
                      booksRef.doc(turkce.text).set(kitapData);

                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Words()));
                    }),
                    child: const Text(
                      "Kitabı Kaydet",
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
