import 'dart:math';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zehra/main_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/register.dart';
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
  var sayi;
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
              const SizedBox(height: 50),
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
              const SizedBox(height: 7),
              const SizedBox(
                height: 20,
                child: Text(
                  " YA DA",
                  style: TextStyle(color: Color.fromARGB(255, 22, 108, 178)),
                ),
              ),
              const SizedBox(height: 7),
              TextButton(
                onPressed: (() {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Register()));
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
            ],
          ),
        ),
      ),
    );
  }

  girisYap(TextEditingController email, TextEditingController sifre) {
    sayi = 0;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: sifre.text)
        .then((user) {
      sayi = 1;
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => const MainMenu()));
      Fluttertoast.showToast(
        msg: "Giriş başarılı",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });

    if (sayi == 0) {
      Fluttertoast.showToast(
        msg: "giriş başarısız",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
