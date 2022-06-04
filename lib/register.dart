import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zehra/login.dart';
import 'package:zehra/text_widget1.dart';
import 'package:zehra/text_widget2.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late FirebaseAuth auth;
  var sayi = 0;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blue,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 70),
              const Padding(padding: EdgeInsets.all(10.0)),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: TextWidget1(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: TextWidget2()),
              const SizedBox(height: 30),
              TextButton(
                onPressed: (() {
                  kayitYap(email, sifre);
                }),
                child: const Text(
                  "Kayıt Ol",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                ),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateHighScore() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.email);
    userRef.set({
      'email': authUser.email,
      'score': 0,
      'profilUrl':
          'https://firebasestorage.googleapis.com/v0/b/zehrakaya-ae4bf.appspot.com/o/files%2Fprofilbos%2Fuser-member-avatar-face-profile-icon-vector-22965342-e1619819871835.jpg?alt=media&token=0c44cae3-23d1-4471-92a0-753ab4722b58'
    });
  }

  void createUserEmailAndPassword() async {
    var _userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text, password: sifre.text);
    print(_userCredential.toString());
  }

  kayitYap(TextEditingController email, TextEditingController sifre) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.text, password: sifre.text)
        .then((user) {
      Fluttertoast.showToast(
        msg: "Kayıt başarılı",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      sayi = 2;
      _updateHighScore();

      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => LoginPage()));
    });

    toast();
  }

  void toast() {
    if (sayi == 0) {
      Fluttertoast.showToast(
        msg: "Zaten kayıtlı",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
