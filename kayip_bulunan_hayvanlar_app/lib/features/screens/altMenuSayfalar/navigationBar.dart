import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kayipBulunan.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/mama.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/patiTakip.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/profil.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/sahiplen.dart';

class NavigationBarr extends StatefulWidget {
  const NavigationBarr({Key? key}) : super(key: key);

  @override
  State<NavigationBarr> createState() => _NavigationBarrState();
}

class _NavigationBarrState extends State<NavigationBarr> {
  int myCurrentIndex = 0;

  // Sayfalar listesi
  List pages = [
    const Sahiplen(),
    const KayipBulunan(),
    const Mama(),
    const PatiTakip(),
    const Profil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[myCurrentIndex],
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),

            // Yuvarlak köşeler

            child: BottomNavigationBar(
              selectedItemColor: const Color(0XFF783192),
              currentIndex: myCurrentIndex,
              iconSize: 35,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/sahiplen.png',
                    width: 65,
                    height: 65,
                  ),
                  label: 'Sahiplen',
                  backgroundColor: const Color(0xffF6F4F4),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/kayipbulunan.png',
                    width: 65,
                    height: 65,
                  ),
                  label: 'Kayıp/Bulunan',
                  backgroundColor: const Color(0xffF6F4F4),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/mama.png',
                    width: 65,
                    height: 65,
                  ),
                  label: 'Mama Bağışı',
                  backgroundColor: const Color(0xffF6F4F4),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/patiTakip.png',
                    width: 65,
                    height: 65,
                  ),
                  label: 'Pati Takip',
                  backgroundColor: const Color(0xffF6F4F4),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/profil.png',
                    width: 65,
                    height: 65,
                  ),
                  label: 'Profil',
                  backgroundColor: const Color(0xffF6F4F4),
                ),
              ],
              onTap: (myNewCurrent) {
                setState(() {
                  myCurrentIndex = myNewCurrent;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
