import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/welcomeScreen/login.dart'; // LoginScreen import edildi

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500), // Geçiş süresi
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(), // Yeni sayfa
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(
                255, 223, 223, 223), // Arka plan rengi kırmızı olarak ayarlandı
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/splashscreen.png'), // Arka plan resmi
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
