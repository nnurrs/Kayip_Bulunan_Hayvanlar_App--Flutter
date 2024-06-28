import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/welcomeScreen/login.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _ilanlarAcik = false;
  bool _ilanlarAcikBulunan = false;

  @override
  void initState() {
    super.initState();
    _updateUserData(); // Kullanıcı verilerini güncelle
  }

  // Kullanıcı verilerini güncelle
  Future<void> _updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('kullanıcılar')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        setState(() {}); // Sayfayı yeniden çizin
      }
    }
  }
/*
  // Telefon numarası dialogunu göster
  Future<String?> _showPhoneNumberDialog(BuildContext context) async {
    String? phoneNumber;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Telefon Numarasını Girin'),
          content: TextField(
            onChanged: (value) {
              phoneNumber = value;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: 'Telefon Numarası'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _savePhoneNumber(phoneNumber);
                Navigator.of(context).pop(phoneNumber);
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }*/
/*
  // Telefon numarasını kaydet
  Future<void> _savePhoneNumber(String? phoneNumber) async {
    if (phoneNumber != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('kullanıcılar')
            .doc(user.uid)
            .set({'phoneNumber': phoneNumber}, SetOptions(merge: true));
      }
    }
  }*/

  // Çıkış yap
  Future<void> _signOut() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } catch (e) {
      print("Google Sign-In oturumu kapatma hatası: $e");
    }
    await FirebaseAuth.instance.signOut();
  }

  // İlanları aç/kapat
  void _toggleIlanlar() {
    setState(() {
      _ilanlarAcik = !_ilanlarAcik; // Değişkenin değerini tersine çevir
    });
  }

  void _toggleIlanlarBulunan() {
    setState(() {
      _ilanlarAcikBulunan =
          !_ilanlarAcikBulunan; // Değişkenin değerini tersine çevir
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(right: 55.0), // Sağa 10 birimlik boşluk ekler
          child: Center(
            child: const Text(
              'Profil Sayfası',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'aptosbold',
              ),
            ),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 223, 223, 223), // AppBar'ın arka plan rengi
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 223, 223, 223),
              ),
              child: Text(
                'Profil Menüsü',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'aptosbold',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(fontFamily: 'aptoslight'),
              ),
              onTap: () async {
                await _signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            /* ListTile(
              leading: const Icon(Icons.phone), // Butonun ikonu
              title: const Text(
                'Telefon Numarasını Güncelle', // Butonun metni
                style: TextStyle(fontFamily: 'aptoslight'),
              ),
              onTap: () async {
                String? phoneNumber = await _showPhoneNumberDialog(context);
                if (phoneNumber != null) {
                  await _savePhoneNumber(phoneNumber);
                  setState(() {}); // Sayfayı yeniden çizin
                }
              },
            ),*/
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(
          255, 223, 223, 223), // Scaffold'ın arka plan rengi
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 40), // Boşluk ve kenar yuvarlama ayarları
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xffAED1CB),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<User?>(
                future: Future.value(FirebaseAuth.instance.currentUser),
                builder: (context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Bir hata oluştu: ${snapshot.error}'));
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    final user = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'E-posta: ',
                              style: TextStyle(
                                fontFamily: 'aptosbold',
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${user.email}',
                                style: const TextStyle(
                                  fontFamily: 'aptoslight',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Ad: ',
                              style: TextStyle(
                                fontFamily: 'aptosbold',
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${user.displayName ?? "Bilinmiyor"}',
                              style: const TextStyle(
                                fontFamily: 'aptoslight',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const Center(
                      child: Text('Kullanıcı bilgileri bulunamadı.'));
                },
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _toggleIlanlar, // İlanları aç/kapat
              child: Row(
                children: const [
                  Text(
                    'Kayıp Hayvan İlanlarım',
                    style: TextStyle(
                      fontFamily: 'aptosbold',
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // İlanlar açıksa ve ilanlar varsa listeyi göster
            _ilanlarAcik
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('kayıp')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('Bir hata oluştu: ${snapshot.error}'));
                        }
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var doc = snapshot.data!.docs[index];
                              var data = doc.data() as Map<String, dynamic>;
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffAED1CB),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data['foto'] != null) // Fotoğraf varsa
                                      Image.network(
                                        data['foto'],
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    const SizedBox(height: 8),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 223, 223, 223),
                                        borderRadius: BorderRadius.circular(
                                            8), // Kenarları yuvarlama
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${data['ad']}',
                                                  style: const TextStyle(
                                                    fontFamily: 'aptosbold',
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${data['il']}',
                                                style: const TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "CİNS:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['cins'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "TÜR:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['tur'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "RENK:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['renk'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "YAŞ:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['yas'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "CİNSİYET:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['cinsiyet'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "EK NOT:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['ekNot'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'İLETİŞİM İÇİN:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        fontFamily: 'aptosbold',
                                      ),
                                    ),
                                    FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('kullanıcılar')
                                          .doc(data['userId'])
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Hata: ${snapshot.error}');
                                          } else {
                                            var kullaniciData =
                                                snapshot.data?.data()
                                                    as Map<String, dynamic>?;

                                            if (kullaniciData != null &&
                                                kullaniciData['eposta'] !=
                                                    null) {
                                              return Row(
                                                children: [
                                                  const Text(
                                                    "E-Posta:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                      fontFamily: 'aptosbold',
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      kullaniciData['eposta'],
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontFamily:
                                                            'aptoslight',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return const Text('Bulunamadı');
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: Text('Kayıp hayvan bulunamadı.'));
                      },
                    ),
                  )
                : SizedBox.shrink(),
            // İlanlar kapalıysa boş bir widget döndür
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _toggleIlanlarBulunan, // İlanları aç/kapat
              child: Row(
                children: const [
                  Text(
                    'Bulunan Hayvan İlanlarım',
                    style: TextStyle(
                      fontFamily: 'aptosbold',
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // İlanlar açıksa ve ilanlar varsa listeyi göster
            _ilanlarAcikBulunan
                ? Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('bulunan')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('Bir hata oluştu: ${snapshot.error}'));
                        }
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var doc = snapshot.data!.docs[index];
                              var data = doc.data() as Map<String, dynamic>;
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffAED1CB),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (data['foto'] != null) // Fotoğraf varsa
                                      Image.network(
                                        data['foto'],
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    const SizedBox(height: 8),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 223, 223, 223),
                                        borderRadius: BorderRadius.circular(
                                            8), // Kenarları yuvarlama
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${data['ad']}',
                                                  style: const TextStyle(
                                                    fontFamily: 'aptosbold',
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${data['il']}',
                                                style: const TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "CİNS:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['cins'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "TÜR:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['tur'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "RENK:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['renk'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "YAŞ:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['yas'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Text(
                                          "CİNSİYET:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${data['cinsiyet'] ?? ''}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptoslight',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "EK NOT:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "${data['ekNot'] ?? ''}",
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptoslight',
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'İLETİŞİM İÇİN:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        fontFamily: 'aptosbold',
                                      ),
                                    ),
                                    FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('kullanıcılar')
                                          .doc(data['userId'])
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Hata: ${snapshot.error}');
                                          } else {
                                            var kullaniciData =
                                                snapshot.data?.data()
                                                    as Map<String, dynamic>?;

                                            if (kullaniciData != null &&
                                                kullaniciData['eposta'] !=
                                                    null) {
                                              return Row(
                                                children: [
                                                  const Text(
                                                    "E-Posta:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                      fontFamily: 'aptosbold',
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      kullaniciData['eposta'],
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontFamily:
                                                            'aptoslight',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return const Text('Bulunamadı');
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                            child: Text('Bulunan hayvan bulunamadı.'));
                      },
                    ),
                  )
                : SizedBox.shrink(), // İlanlar kapalıysa boş bir widget döndür
          ],
        ),
      ),
    );
  }
}
