import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zehra/authentication.dart';
import 'package:zehra/kolay_buton.dart';
import 'package:zehra/siralama_screen.dart';

class SiralamaButon extends StatefulWidget {
  const SiralamaButon({Key? key}) : super(key: key);

  @override
  State<SiralamaButon> createState() => _SiralamaButonState();
}

class _SiralamaButonState extends State<SiralamaButon> {
  @override
  Widget build(BuildContext context) {
    return KolayButton(
        title: 'Sıralama',
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SiralamaScreen()));
        });
  }
}
