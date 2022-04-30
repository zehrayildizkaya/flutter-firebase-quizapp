
import 'package:flutter/material.dart';

class KolayButton extends StatelessWidget {
  const KolayButton({
    Key? key, required this.title, required this.onTap, this.isPrimary=true,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isPrimary ? ElevatedButton(
          onPressed: () => onTap()
          ,
          style: ElevatedButton.styleFrom(
              primary: Colors.cyan.shade900,
              padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
              shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 4),
              )),
          child: Text(title
          )): TextButton(onPressed: () => onTap(),child: Text(title , style:TextStyle()))
    );
  }
}