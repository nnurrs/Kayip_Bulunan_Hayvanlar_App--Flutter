import 'package:flutter/material.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/tabBarSayfalar/bulunan.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/tabBarSayfalar/kayip.dart';

class KayipBulunan extends StatefulWidget {
  const KayipBulunan({Key? key}) : super(key: key);

  @override
  State<KayipBulunan> createState() => _KayipBulunanState();
}

class _KayipBulunanState extends State<KayipBulunan> {
  // ignore: unused_field
  int _selectedIndex = 0;

  static const List<Widget> _tabPages = <Widget>[
    Kayip(), // "Kayip" sayfasının içeriği
    Bulunan(), // "Bulunan" sayfasının içeriği
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Index 0 seçildiğinde "kayip.dart" sayfasına yönlendir
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Kayip()),
      );
    }
    // Index 1 seçildiğinde "bulunan.dart" sayfasına yönlendir
    else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bulunan()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Image.asset(
                    'assets/images/kayip.png',
                    width: 42,
                    height: 42,
                  ),
                  text: 'Kayıp',
                ),
                Tab(
                  icon: Image.asset(
                    'assets/images/bulunan.png',
                    width: 42,
                    height: 42,
                  ),
                  text: 'Bulunan',
                ),
              ],
            ),
            backgroundColor: const Color(0xffAED1CB),
          ),
          body: const TabBarView(
            children: _tabPages,
          ),
        ),
      ),
    );
  }
}
