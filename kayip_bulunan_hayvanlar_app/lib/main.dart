import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kayipBulunan.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/mama.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/patiTakip.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/profil.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/sahiplen.dart';
import 'package:kayip_bulunan_hayvanlar_app/splashscreen.dart';
import 'firebase_options.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kayıp ve Bulunan Hayvanlar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF783192)),
        useMaterial3: true,
      ),
      routes: {
        //navigation bar da sayfa yönlendirmeleri için
        '/sahiplen': (context) => const Sahiplen(),
        '/kayipBulunan': (context) => const KayipBulunan(),
        '/mama': (context) => const Mama(),
        '/patiTakip': (context) => const PatiTakip(),
        '/profil': (context) => const Profil(),
      },
      initialRoute: '/',
      home:
          SplashScreen(), // SplashScreen'i başlangıç ekranı olarak ayarlıyoruz
    );
  }
}
