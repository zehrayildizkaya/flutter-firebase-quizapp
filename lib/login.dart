import 'dart:math';
import 'dart:ui';
import 'package:zehra/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/siralama_buton.dart';
import 'package:zehra/text_widget1.dart';
import 'package:zehra/text_widget2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('İngilizce Öğreniyorum', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.green,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
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
              TextButton(
                onPressed: (() {
                  girisYap(email, sifre);
                }),
                child: const Text(
                  "Oturum Aç",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 0, 162, 199)),
                ),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              SizedBox(height:20),
              

            ],
          ),
        ),
      ),
    );
  }

  void createUserEmailAndPassword() async {
    var _userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text, password: sifre.text);
    print(_userCredential.toString());
  }

  kayitYap(TextEditingController email, TextEditingController sifre) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: sifre.text);
  }

  girisYap(TextEditingController email, TextEditingController sifre) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: sifre.text)
        .then((user) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const MainMenu()));
    });
  }
}
