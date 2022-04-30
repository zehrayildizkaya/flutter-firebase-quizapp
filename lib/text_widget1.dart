import 'package:flutter/material.dart';

class TextWidget1 extends StatefulWidget { 

  @override
  State<TextWidget1> createState() => _TextWidget1State();
}


    TextEditingController email = TextEditingController();
class _TextWidget1State extends State<TextWidget1> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 162, 199)),
        ),
        labelText: "Kullanıcı Adı",
        prefixIcon: Icon(
          Icons.email,
          color: Color.fromARGB(255, 0, 162, 199),
        ),
        labelStyle: TextStyle(
          color: (Color.fromARGB(255, 0, 162, 199)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 162, 199),
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Kullanıcı Adı Giriniz";
        } else {
          return null;
        }
      },
    );
  }
}