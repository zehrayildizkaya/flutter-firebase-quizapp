import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zehra/arka_plan.dart';
import 'package:zehra/calisma.dart';

import 'package:zehra/kolay_buton.dart';
import 'package:zehra/question.dart';
import 'package:flutter/material.dart';

class SonucScreen extends StatefulWidget {
  const SonucScreen({
    Key? key,
    required this.score,
    required this.questions,
  }) : super(key: key);

  final int score;
  final List<Question> questions;

  @override
  State<SonucScreen> createState() => _SonucScreenState();
}

class _SonucScreenState extends State<SonucScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: ArkaPlan(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sonuç: ${widget.score} / 5",
                  style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 30,
              ),
              Text("Puan: ${widget.score}", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 50,
              ),
              KolayButton(
                  title: 'Başa Dön',
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Calisma()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateHighScore();
  }

  Future<void> _updateHighScore() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.email);
    final userDoc = await userRef.get();
    if (userDoc.exists) {
      final user = userDoc.data();
      if (user == null) return;
      final lastHighscore = user['score'];
      if (lastHighscore >= widget.score) {
        return;
      }
      userRef.update({'score': widget.score});
      return;
    }
    userRef.set({
      'email': authUser.email,
      'score': widget.score,
    });
  }
}
