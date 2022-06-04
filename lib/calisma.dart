import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zehra/arka_plan.dart';
import 'package:zehra/kolay.dart';
import 'package:zehra/kolay_buton.dart';
import 'package:zehra/question.dart';

import 'package:flutter/material.dart';

class Calisma extends StatelessWidget {
  const Calisma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 245, 216),
      appBar: AppBar(
        title: const Text('ÇALIŞMA', style: TextStyle(fontSize: 25)),
        backgroundColor: Color.fromARGB(255, 9, 68, 27),
      ),
      body: SizedBox.expand(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final questionDocs = snapshot.data!.docs;
                  final questions = questionDocs
                      .map((e) => Question.fromQueryDocumentSnapshot(e))
                      .toList();

                  return KolayButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Kolay(
                                totalTime: 120,
                                questions: questions,
                                katsayi: 1)));
                      },
                      title: "Kolay");
                }),
            SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questionstwo')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final questionDocs = snapshot.data!.docs;
                  final questions = questionDocs
                      .map((e) => Question.fromQueryDocumentSnapshot(e))
                      .toList();

                  return KolayButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Kolay(
                                  totalTime: 150,
                                  questions: questions,
                                  katsayi: 2,
                                )));
                      },
                      title: "Orta");
                }),
            SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questionsthree')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final questionDocs = snapshot.data!.docs;
                  final questions = questionDocs
                      .map((e) => Question.fromQueryDocumentSnapshot(e))
                      .toList();

                  return KolayButton(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Kolay(
                                totalTime: 180,
                                questions: questions,
                                katsayi: 3)));
                      },
                      title: "Zor");
                }),
          ],
        ),
      )),
    );
  }
}
