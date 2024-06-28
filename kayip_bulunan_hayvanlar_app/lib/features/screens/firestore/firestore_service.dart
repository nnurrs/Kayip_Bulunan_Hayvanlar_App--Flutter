import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static Future<void> saveUserInfoToFirestore(User user) async {
    // Firestore referansını oluştur
    final firestoreInstance = FirebaseFirestore.instance;

    // Firestore'a kullanıcı bilgilerini kaydet
    await firestoreInstance.collection('kullanıcılar').doc(user.uid).set({
      'ad': user.displayName ?? '', // Kullanıcının adı
      'eposta': user.email ?? '', // Kullanıcının e-posta adresi
      //  'phoneNumber': null, // Başlangıçta telefon numarasını null olarak ayarla
    });
  }

  /*Future<void> updateUserPhoneNumber(String phoneNumber) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'phone_number': phoneNumber});
    }
  }*/
}
