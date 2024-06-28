//sgn in in firebase kısmı
//riverpod kullanıyoruz. burda ilk olarak riverpod ekledik
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//--------------
//riverpod->klasörler içinde rahat bir şekilde ulaşabilmeyi sağlar
// ignore: non_constant_identifier_names
final AuthRepositoryProvider =
    Provider((ref) => AuthRepository(auth: FirebaseAuth.instance));

//----------
class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
