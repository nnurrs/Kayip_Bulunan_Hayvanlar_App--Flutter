import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/navigationBar.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/firestore/firestore_service.dart';
import 'package:kayip_bulunan_hayvanlar_app/services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child: Image.asset(
              "assets/images/loginArkaPlan.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25), // Yanlardan 20 birim içeriye çek
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius:
                        BorderRadius.circular(50), // Kenarları yuvarlak yapar
                    boxShadow: [
                      // Gölge eklemek için boxShadow kullanın
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0,
                            1), // Gölgeyi butonun altına doğru yaymak için bir ofset
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseServices().signInWithGoogle();
                      await FirestoreService.saveUserInfoToFirestore(
                          //kullanıcılar koleksiyonuna bilgileri yazar
                          FirebaseAuth.instance.currentUser!);

                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationBarr()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 100)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/google.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Google Hesabı İle Giriş Yap",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 80), // Alt kısma 80 birimlik bir boşluk ekler
            ],
          ),
        ],
      ),
    );
  }
}
