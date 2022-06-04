import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/arka_plan.dart';
import 'package:zehra/not_ekle.dart';

class Notlar extends StatelessWidget {
  const Notlar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: ArkaPlan(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        const Text('Notlarım', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => NotEkle()));
                          },
                          child:
                              Text("Not Ekle ", style: TextStyle(fontSize: 25)),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(authUser!.email)
                              .collection('notlar')
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            final users = snapshots.data!.docs;

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () async {
                                                await users[index]
                                                    .reference
                                                    .delete();
                                              }),
                                          SizedBox(height: 70),
                                          Text(users[index]['not'],
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      )),
                                );
                              },
                              itemCount: users.length,
                            );
                          }),
                    ),
                  ],
                ))));
  }
}
