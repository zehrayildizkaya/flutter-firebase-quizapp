import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zehra/gradient_box.dart';

class Words extends StatelessWidget {
  const Words({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBox(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text('Kelimeler', style: TextStyle(fontSize: 30)),
                    SizedBox(height: 20),
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
                                    trailing: Text(users[index]['mean']),
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
