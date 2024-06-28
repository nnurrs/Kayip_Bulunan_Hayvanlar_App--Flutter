import 'package:flutter/material.dart';

//bu sayfa ana sayfa olcak
class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Hello World",
              style: TextStyle(
                fontSize: 40,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
