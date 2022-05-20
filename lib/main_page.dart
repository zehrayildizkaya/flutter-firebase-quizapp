import 'package:flutter/material.dart';
import 'package:zehra/arka_plan.dart';
import 'package:zehra/login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ArkaPlan(
            child: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const SizedBox(
              width: 200,
              height: 50,
              child: Center(
                child: Text("İNGİLİZCE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                        color: Colors.white)),
              )),
          const SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Text("ÖĞRENİYORUM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 40,
                      color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 3, 92, 34),
                padding: const EdgeInsets.fromLTRB(65, 20, 65, 20),
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: Color.fromARGB(232, 255, 255, 255),
                    width: 4,
                  ),
                )),
            child: const Text('BAŞLA', style: TextStyle(fontSize: 25)),
          )
        ],
      ),
    )));
  }
}
