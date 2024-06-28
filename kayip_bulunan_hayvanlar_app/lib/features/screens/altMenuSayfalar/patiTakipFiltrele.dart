import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatiTakipFiltrele extends StatefulWidget {
  const PatiTakipFiltrele({super.key});

  @override
  State<PatiTakipFiltrele> createState() => _PatiTakipFiltreleState();
}

class _PatiTakipFiltreleState extends State<PatiTakipFiltrele> {
  late List<String> favoriteIds = [];
  Future<void> checkFavorites() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('patiTakip').get();

    setState(() {
      favoriteIds =
          querySnapshot.docs.map((doc) => doc['ad'] as String).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    checkFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FilterScreen(),
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedCins;
  String? selectedCinsiyet;
  String? selectedIl;
  String? selectedYas;
  String? selectedislemTuru;

  // İlk açıldığında tüm ilanları göstermemek için bir kontrol değişkeni
  bool showAllAds = false;

  get favoriteIds => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Takip Edilen Hayvanları Filtreleme Ekranı',
          style: TextStyle(fontFamily: 'aptosbold'),
        ),
        flexibleSpace: const Opacity(
          opacity: 0.8,
          child: Image(
            image: AssetImage('assets/images/filtreleAppbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 227, 223, 223),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/filtreleArkaPlan.png'), // Arka plan görüntüsü
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity, // Tüm alanı kapla
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0XFF783192)), // Kenar rengi
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // İçerik rengi beyaz
                  ),

                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'İşlem Türü',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                    ),
                    value: selectedislemTuru,
                    onChanged: (newValue) {
                      setState(() {
                        selectedislemTuru = newValue;
                      });
                    },
                    items: [
                      'kayıp',
                      'bulunan',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity, // Tüm alanı kapla
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0XFF783192)), // Kenar rengi
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // İçerik rengi beyaz
                  ),

                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Cins',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                    ),
                    value: selectedCins,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCins = newValue;
                      });
                    },
                    items: ['Kedi', 'Köpek', 'Kuş', 'Diğer']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFF783192)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Cinsiyet',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                    ),
                    value: selectedCinsiyet,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCinsiyet = newValue;
                      });
                    },
                    items: ['Dişi', 'Erkek', 'Bilinmiyor']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFF783192)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'İl',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                    ),
                    value: selectedIl,
                    onChanged: (newValue) {
                      setState(() {
                        selectedIl = newValue;
                      });
                    },
                    items: [
                      'Adana',
                      'Adıyaman',
                      'Afyonkarahisar',
                      'Ağrı',
                      'Amasya',
                      'Ankara',
                      'Antalya',
                      'Artvin',
                      'Aydın',
                      'Balıkesir',
                      'Bilecik',
                      'Bingöl',
                      'Bitlis',
                      'Bolu',
                      'Burdur',
                      'Bursa',
                      'Çanakkale',
                      'Çankırı',
                      'Çorum',
                      'Denizli',
                      'Diyarbakır',
                      'Edirne',
                      'Elazığ',
                      'Erzincan',
                      'Erzurum',
                      'Eskişehir',
                      'Gaziantep',
                      'Giresun',
                      'Gümüşhane',
                      'Hakkari',
                      'Hatay',
                      'Isparta',
                      'Mersin',
                      'İstanbul',
                      'İzmir',
                      'Kars',
                      'Kastamonu',
                      'Kayseri',
                      'Kırklareli',
                      'Kırşehir',
                      'Kocaeli',
                      'Konya',
                      'Kütahya',
                      'Malatya',
                      'Manisa',
                      'Kahramanmaraş',
                      'Mardin',
                      'Muğla',
                      'Muş',
                      'Nevşehir',
                      'Niğde',
                      'Ordu',
                      'Rize',
                      'Sakarya',
                      'Samsun',
                      'Siirt',
                      'Sinop',
                      'Sivas',
                      'Tekirdağ',
                      'Tokat',
                      'Trabzon',
                      'Tunceli',
                      'Şanlıurfa',
                      'Uşak',
                      'Van',
                      'Yozgat',
                      'Zonguldak',
                      'Aksaray',
                      'Bayburt',
                      'Karaman',
                      'Kırıkkale',
                      'Batman',
                      'Şırnak',
                      'Bartın',
                      'Ardahan',
                      'Iğdır',
                      'Yalova',
                      'Karabük',
                      'Kilis',
                      'Osmaniye',
                      'Düzce',
                      // Diğer illeri buraya ekleyin
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity: 0.7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFF783192)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Yaş',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 17),
                    ),
                    value: selectedYas,
                    onChanged: (newValue) {
                      setState(() {
                        selectedYas = newValue;
                      });
                    },
                    items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
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
                          builder: (context) => const PatiTakipFiltrele(),
                        ),
                      );
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      'Sıfırla', // Butonun metni
                      style: TextStyle(
                        color: Color.fromARGB(255, 223, 223, 223),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF783192), // Buton rengi
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: showAllAds
                        ? FirebaseFirestore.instance
                            .collection('patiTakip')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('patiTakip')
                            .where('islemTürü', isEqualTo: selectedislemTuru)
                            .where('cins', isEqualTo: selectedCins)
                            .where('cinsiyet', isEqualTo: selectedCinsiyet)
                            .where('il', isEqualTo: selectedIl)
                            .where('yas', isEqualTo: selectedYas)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('Bir hata oluştu'));
                      }
                      final documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return const Center(
                            child: Text(
                                'Arama Kriterlerine uygun ilan bulunamadı'));
                      }
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String kayipIslem = data['islemTürü'];
                          String kayipduzeltilmis = //baş harfi büyütmek için
                              kayipIslem.substring(0, 1).toUpperCase() +
                                  kayipIslem.substring(1);
                          String bulunanIslem = data['islemTürü'];
                          String bulunanduzeltilmis =
                              bulunanIslem.substring(0, 1).toUpperCase() +
                                  bulunanIslem.substring(1);
                          DateTime? kayipTarih = data['kayıptarih'] != null
                              ? (data['kayıptarih'] as Timestamp).toDate()
                              : null;
                          DateTime? bulunanTarih = data['bulunantarih'] != null
                              ? (data['bulunantarih'] as Timestamp).toDate()
                              : null;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              padding: const EdgeInsets.all(10.0),
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
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 170,
                                        child: data['foto'] != null
                                            ? Image.network(
                                                data['foto'],
                                                fit: BoxFit.cover,
                                              )
                                            : const Placeholder(),
                                      ),
                                      const SizedBox(height: 10),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${data['ad'] ?? ''}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      fontFamily: 'aptosbold',
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['il'] ?? ''}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                      if (data['islemTürü'] == 'kayıp')
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'İŞLEM TÜRÜ: ',
                                                style: TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 17,
                                                  color: Colors
                                                      .black, // 'İŞLEM TÜRÜ: ' metninin rengi siyah
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' $kayipduzeltilmis',
                                                style: const TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 17,
                                                  color: Colors
                                                      .red, // data['islemTürü'] metninin rengi kırmızı
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 6),
                                      if (data['islemTürü'] == 'bulunan')
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'İŞLEM TÜRÜ: ',
                                                style: TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' $bulunanduzeltilmis',
                                                style: const TextStyle(
                                                  fontFamily: 'aptosbold',
                                                  fontSize: 17,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 6),
                                      if (kayipTarih != null)
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptosbold',
                                              color: Colors.black,
                                            ),
                                            children: [
                                              const TextSpan(
                                                  text: 'KAYBOLDUĞU TARİH: '),
                                              TextSpan(
                                                text:
                                                    '${kayipTarih.day}/${kayipTarih.month}/${kayipTarih.year}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'aptoslight',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 2),
                                      if (bulunanTarih != null)
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptosbold',
                                              color: Colors.black,
                                            ),
                                            children: [
                                              const TextSpan(
                                                  text: 'BULUNDUĞU TARİH: '),
                                              TextSpan(
                                                text:
                                                    '${bulunanTarih.day}/${bulunanTarih.month}/${bulunanTarih.year}',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'aptoslight',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                            color: Colors.black,
                                          ),
                                          children: [
                                            const TextSpan(text: 'CİNS: '),
                                            TextSpan(
                                              text: '${data['cins']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Text(
                                            'TÜR: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptosbold',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${data['tur']}',
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
                                            'RENK: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptosbold',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${data['renk']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                            color: Colors.black,
                                          ),
                                          children: [
                                            const TextSpan(text: 'YAŞ: '),
                                            TextSpan(
                                              text: '${data['yas']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                            color: Colors.black,
                                          ),
                                          children: [
                                            const TextSpan(text: 'CİNSİYET: '),
                                            TextSpan(
                                              text: '${data['cinsiyet']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Text(
                                            'EK NOT: ',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'aptosbold',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${data['ekNot']}',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'aptoslight',
                                              ),
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
                                            .doc((document.data()
                                                as Map)['userId'])
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
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF783192),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/patiTakipBeyaz.png', // Özel fotoğrafın yolunu belirtin
                                          width:
                                              40, // İstediğiniz genişliği ayarlayın
                                          height:
                                              40, // İstediğiniz genişliği ayarlayın
                                        ),
                                        onPressed: () async {
                                          // İlgili belgeyi kaldır
                                          await FirebaseFirestore.instance
                                              .collection('patiTakip')
                                              .doc(document.id)
                                              .delete();
                                          // Widget'ı yenile
                                          setState(() {
                                            // Eğer belge favoriler listesinde varsa, listeden kaldır

                                            if (favoriteIds != null &&
                                                favoriteIds
                                                    .contains(document.id)) {
                                              favoriteIds.remove(document.id);
                                            }
                                          });

                                          // SnackBar göster
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'İlan favorilerden kaldırıldı'),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
    );
  }
}
