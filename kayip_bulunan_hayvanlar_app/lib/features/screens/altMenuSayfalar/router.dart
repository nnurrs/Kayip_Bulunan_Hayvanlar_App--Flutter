import 'package:flutter/material.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kayipBulunan.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/mama.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/patiTakip.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/profil.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/sahiplen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sahiplen':
        return MaterialPageRoute(
          builder: (_) => const Sahiplen(),
        );
      case '/kayipBulunan':
        return MaterialPageRoute(
          builder: (_) => const KayipBulunan(),
        );
      case '/mama':
        return MaterialPageRoute(
          builder: (_) => const Mama(),
        );
      case '/patiTakip':
        return MaterialPageRoute(
          builder: (_) => const PatiTakip(),
        );
      case '/profil':
        return MaterialPageRoute(
          builder: (_) => const Profil(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
