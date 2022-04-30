import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zehra/text_widget2.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Şifre değiştirme")),
        body: SingleChildScrollView(
          child: Form(
              child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: TextWidget2(),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: (() {
                  changePassword();
                }),
                child: Text(" Şifreyi değiştir"),
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 162, 199)),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              )
            ],
          )),
        ));
  }

  void changePassword() async {
    await auth.currentUser!.updatePassword("1234567");
    await auth.signOut();
  }
}
