import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/tabBarSayfalar/bulunanFiltrele.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/firestore/bulunanForm.dart';

class Bulunan extends StatefulWidget {
  const Bulunan({super.key});

  @override
  State<Bulunan> createState() => _BulunanState();
}

class _BulunanState extends State<Bulunan> {
  late List<Map<String, dynamic>> documents = [];
  late List<Map<String, dynamic>> filteredDocuments = [];

  late List<String> favoriteIds = [];

  Future<void> getDocuments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('bulunan').get();

    setState(() {
      documents = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((doc) =>
              doc['ad'] != null &&
              doc['yas'] != null &&
              doc['il'] != null &&
              doc['cins'] != null &&
              doc['tur'] != null)
          .toList();
      filteredDocuments = List.from(documents);
    });
  }

  Future<void> checkFavorites() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('patiTakip').get();

    setState(() {
      favoriteIds =
          querySnapshot.docs.map((doc) => doc['ad'] as String).toList();
    });
  }

  void filterDocuments(String searchText) {
    setState(() {
      filteredDocuments = documents.where((doc) {
        if (doc['ad'] != null &&
            doc['il'] != null &&
            doc['cins'] != null &&
            doc['tur'] != null &&
            doc['cinsiyet'] != null) {
          String ad = doc['ad'].toString().toLowerCase();
          String il = doc['il'].toString().toLowerCase();
          String cins = doc['cins'].toString().toLowerCase();
          String tur = doc['tur'].toString().toLowerCase();
          String cinsiyet = doc['cinsiyet'].toString().toLowerCase();

          return ad.contains(searchText.toLowerCase()) ||
              il.contains(searchText.toLowerCase()) ||
              cins.contains(searchText.toLowerCase()) ||
              tur.contains(searchText.toLowerCase()) ||
              cinsiyet.contains(searchText.toLowerCase());
        }
        return false;
      }).toList();

      // Arama sonuçları güncellendiğinde favori ilanları kontrol et
      checkFavorites();
    });
  }

  @override
  void initState() {
    super.initState();
    getDocuments();
    checkFavorites(); // Favori ilanları kontrol et
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BulunanForm()),
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0XFF783192),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: 370,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BulunanFiltrele(),
                      ),
                    );
                  },
                  child: Text(
                    'Filtreleme', // Butonun metni
                    style: TextStyle(
                      color: const Color.fromARGB(255, 223, 223, 223),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF783192), // Buton rengi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
            if (filteredDocuments.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  var data = filteredDocuments[index];
                  // ignore: unnecessary_null_comparison
                  DateTime? tarih = data != null && data['bulunantarih'] != null
                      ? (data['bulunantarih'] as Timestamp).toDate()
                      : null;
                  return Container(
                    //key: ValueKey<int>(index),
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    decoration: BoxDecoration(
                      color: const Color(0xffAED1CB),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 200,
                                // ignore: unnecessary_null_comparison
                                child: data != null && data['foto'] != null
                                    ? Image.network(
                                        data['foto'],
                                        fit: BoxFit.cover,
                                      )
                                    : const Placeholder(),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 223, 223, 223),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data['ad'] ?? ''}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily: 'aptosbold',
                                                ),
                                              ),
                                              Text(
                                                "${data['il'] ?? ''}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  fontFamily: 'aptosbold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const Text(
                                        "BULUNDUĞU TARİH:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          fontFamily: 'aptosbold',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      tarih != null
                                          ? Text(
                                              "${tarih.day}/${tarih.month}/${tarih.year}",
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
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
                                          var kullaniciData = snapshot.data
                                              ?.data() as Map<String, dynamic>?;

                                          if (kullaniciData != null &&
                                              kullaniciData['eposta'] != null) {
                                            return Row(
                                              children: [
                                                const Text(
                                                  "E-Posta:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                      fontFamily: 'aptoslight',
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
                            ],
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                // Favori ilan eklemesi veya kaldırması yapıldığında favoriIds listesini güncelle

                                // İlgili ilanın özelliklerini al
                                Map<String, dynamic> ilan =
                                    filteredDocuments[index];

                                // İlgili ilanın favorilere eklenip eklenmediğini kontrol etmek için bir referans al
                                CollectionReference patiTakipRef =
                                    FirebaseFirestore.instance
                                        .collection('patiTakip');

                                // İlgili ilanın favorilere eklenip eklenmediğini kontrol etmek için bir sorgu oluştur
                                Query query = patiTakipRef.where('ad',
                                    isEqualTo: ilan['ad']);

                                // İlgili ilanın favorilere eklenip eklenmediğini kontrol et
                                query.get().then((QuerySnapshot querySnapshot) {
                                  // Eğer ilan favorilere eklenmişse, favorilerden kaldır
                                  if (querySnapshot.size > 0) {
                                    querySnapshot.docs.first.reference.delete();
                                    // Bildirim göster
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'İlan favorilerden kaldırılmıştır')));
                                  } else {
                                    // İlan favorilere eklenmemişse, ilanı favorilere ekle
                                    ilan['islemTürü'] = 'bulunan';
                                    FirebaseFirestore.instance
                                        .collection('patiTakip')
                                        .add(ilan);
                                    // Bildirim göster
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'İlan favorilere eklendi')));
                                  }
                                  checkFavorites();
                                });
                              },
                              icon: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: favoriteIds.contains(data['ad'])
                                      ? const Color(0XFF783192)
                                      : const Color.fromARGB(
                                          255, 223, 223, 223),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/patiTakip.png',
                                  color: favoriteIds.contains(data['ad'])
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            if (filteredDocuments.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Arama kriterlerine uygun bulunan hayvan ilanı bulunamadı.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'aptosbold',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
