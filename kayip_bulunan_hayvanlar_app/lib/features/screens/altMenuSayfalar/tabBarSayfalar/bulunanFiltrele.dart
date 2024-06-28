import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BulunanFiltrele extends StatefulWidget {
  const BulunanFiltrele({super.key});

  @override
  State<BulunanFiltrele> createState() => _BulunanFiltreleState();
}

class _BulunanFiltreleState extends State<BulunanFiltrele> {
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

  // İlk açıldığında tüm ilanları göstermemek için bir kontrol değişkeni
  bool showAllAds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bulunan Hayvan Filtreleme Ekranı',
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
                          builder: (context) => const BulunanFiltrele(),
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
                            .collection('bulunan')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('bulunan')
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
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // Yatayda boşluk
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final document = documents[index];
                          DateTime? tarih = document.data() != null &&
                                  (document.data() as Map)['bulunantarih'] !=
                                      null
                              ? ((document.data() as Map)['bulunantarih']
                                      as Timestamp)
                                  .toDate()
                              : null;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffAED1CB),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (document.data() as Map)['foto'] != null
                                        ? Image.network(
                                            (document.data() as Map)['foto'],
                                            fit: BoxFit.cover,
                                          )
                                        : const Placeholder(),
                                    // Ad ve il alanlarını bir kutu içine al
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
                                                  '${(document.data() as Map)['ad']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily: 'aptosbold',
                                                  ),
                                                ),
                                                Text(
                                                  '${(document.data() as Map)['il']}',
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
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text(
                                          'BULUNDUĞU TARİH: ',
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
                                          'CİNS: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Text(
                                          '${(document.data() as Map)['cins']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                          'TÜR: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Text(
                                          '${(document.data() as Map)['tur']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                          'RENK: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Text(
                                          '${(document.data() as Map)['renk']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                          'YAŞ: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Text(
                                          '${(document.data() as Map)['yas']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                          'CİNSİYET: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Text(
                                          '${(document.data() as Map)['cinsiyet']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
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
                                          'EK NOT: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'aptosbold',
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${(document.data() as Map)['ekNot']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
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
                                                  Text(
                                                    kullaniciData['eposta'],
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'aptoslight',
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
                          );
                        },
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
