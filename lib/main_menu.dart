import 'package:zehra/calisma.dart';
import 'package:flutter/material.dart';
import 'package:zehra/profil.dart';
import 'package:zehra/words.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 81, 158, 100),
      appBar: AppBar(
        title:
            const Text('İNGİLİZCE ÖĞRENİYORUZ', style: TextStyle(fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 13, 93, 26),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 150, 15, 50),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profil()));
                },
                icon: const Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                ),
                label: const Text(""),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 13, 93, 26),
                    padding: const EdgeInsets.fromLTRB(60, 20, 70, 20),
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white, width: 4),
                    ))),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Calisma()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 13, 93, 26),
                    padding: const EdgeInsets.fromLTRB(70, 25, 70, 25),
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white, width: 4),
                    )),
                child: const Text(
                  'Çalışma',
                  style: TextStyle(fontSize: 35),
                )),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Words()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 13, 93, 26),
                    padding: const EdgeInsets.fromLTRB(70, 25, 70, 25),
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.white, width: 4),
                    )),
                child: const Text(
                  'Kelimeler',
                  style: TextStyle(fontSize: 35),
                )),
          ],
        ),
      ),
    );
  }
}
