/* import 'package:zehra/gradient_box.dart';
import 'package:zehra/main_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: GradientBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("İNGİLİZCE ÖĞRENİYORUM"),
            const SizedBox(height: 50),
            SizedBox(
                height: 40,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainMenu()));
                    },
                    child: const Text("Ana Menü")))
          ],
        ),
      )),
    );
  }
}
 */