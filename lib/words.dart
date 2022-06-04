import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zehra/arka_plan.dart';
import 'package:zehra/words_ekleme.dart';

class Words extends StatelessWidget {
  const Words({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        const Text('Kelimeler', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          width: 50,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => WordsEkleme()));
                            },
                            icon: new Icon(Icons.add_card))
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('words')
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
                                  child: ListTile(
                                    title: Text(users[index]['word']),
                                    subtitle: Text(users[index]['mean']),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await users[index].reference.delete();
                                        }),
                                  ),
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
