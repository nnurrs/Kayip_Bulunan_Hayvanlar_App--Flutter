// Firestore instance'ı oluştur
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Kayıp formu için veri ekleme fonksiyonu
Future<void> addLostItem(String userId, String documentId) async {
  try {
    // Şuanki tarih ve saat bilgisini al
    DateTime now = DateTime.now();

    // İlan koleksiyonuna veri ekle
    DocumentReference docRef = await _firestore.collection('ilan').add({
      'islemTürü': 'kayıp',
      'islemTarihi': now,
      'islemDurum': '0',
      'userId': userId, // Kullanıcı ID'sini ekle
      'hayvanId': documentId, // Hayvanın belge ID'sini ekle
    });
    print('Kayıp formu verisi eklendi. Belge ID: ${docRef.id}');
  } catch (e) {
    print('Hata: $e');
  }
}

// Bulunan formu için veri ekleme fonksiyonu
Future<void> addFoundItem(String userId, String documentId) async {
  try {
    // Şuanki tarih ve saat bilgisini al
    DateTime now = DateTime.now();

    // İlan koleksiyonuna veri ekle
    DocumentReference docRef = await _firestore.collection('ilan').add({
      'islemTürü': 'bulunan',
      'islemTarihi': now,
      'islemDurum':
          '0', //0-> bekliyor 1->basarılı (bu 1 i uyg. da profilde gösterirken veri tabanından 1 çekip başarılı yazdırcaz)
      'userId': userId, // Kullanıcı ID'sini ekle
      'hayvanId': documentId, // Hayvanın belge ID'sini ekle
    });
    print('Bulunan formu verisi eklendi. Belge ID: ${docRef.id}');
  } catch (e) {
    print('Hata: $e');
  }
}
