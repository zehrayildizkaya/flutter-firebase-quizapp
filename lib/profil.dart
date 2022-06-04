import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zehra/login.dart';
import 'package:zehra/main_menu.dart';
import 'package:zehra/notlar.dart';
import 'package:zehra/siralama_buton.dart';
import 'package:zehra/updatepassword.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late FirebaseAuth auth;
  late String url;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _foto;
  final ImagePicker _sec = ImagePicker();

  Future galeri() async {
    final secilendosya = await _sec.pickImage(source: ImageSource.gallery);

    setState(() {
      if (secilendosya != null) {
        _foto = File(secilendosya.path);
        uploadFile();
      } else {
        print('Resim seçilmedi');
      }
    });
  }

  Future kamera() async {
    final secilendosya = await _sec.pickImage(source: ImageSource.camera);

    setState(() {
      if (secilendosya != null) {
        _foto = File(secilendosya.path);
        uploadFile();
      } else {
        print('Resim seçilmedi');
      }
    });
  }

  Future uploadFile() async {
    if (_foto == null) return;
    final fileName = basename(_foto!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');

      await ref.putFile(_foto!);
      url = (await ref.getDownloadURL()).toString();
      _updateScore();
      print(url);
    } catch (e) {
      print('hata');
    }
  }

  Future<void> _updateScore() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.email);
    final userDoc = await userRef.get();
    userRef.update({'profilUrl': url});
  }

  @override
  void initState() {
    super.initState();

    auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        const Text('Oturum kapalı');
      } else {
        Text('Oturum Açık ${user.email} ve email durumu ${user.emailVerified}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PROFİL', style: TextStyle(fontSize: 20)),
          backgroundColor: Color.fromARGB(255, 16, 92, 44),
          actions: <Widget>[
            new IconButton(
                onPressed: () {
                  signOutUser();
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => LoginPage()));
                },
                icon: new Icon(Icons.exit_to_app_rounded, size: 30))
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _secme(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color.fromARGB(255, 27, 136, 43),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context, snapshots) {
                              if (!snapshots.hasData) return Center();
                              final users = snapshots.data!.docs;
                              return Image.network(users[0]['profilUrl']);
                            }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (!snapshots.hasData) return Center();
                        final users = snapshots.data!.docs;
                        return Column(
                          children: [
                            Text("Email: ${users[0]['email']}",
                                style: TextStyle(fontSize: 20)),
                            Text("Score: ${users[0]['score'].toString()}",
                                style: TextStyle(fontSize: 20)),
                          ],
                        );
                      }),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Notlar()));
                  }),
                  child: const Text(
                    "NOTLAR",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 24, 96, 48)),
                  ),
                  style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 10, 71, 24)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                SizedBox(height: 30),
                SiralamaButon(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdatePassword()));
                  }),
                  child: const Text(
                    "Şifre değiştir",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 24, 96, 48)),
                  ),
                  style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 10, 71, 24)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
              ],
            ),
          ),
        ));
  }

  void _secme(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeriden seç'),
                      onTap: () {
                        galeri();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      kamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void signOutUser() async {
    await auth.signOut();
  }
}
