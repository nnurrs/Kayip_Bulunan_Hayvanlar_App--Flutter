import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/patiTakipFiltrele.dart';

class PatiTakip extends StatefulWidget {
  const PatiTakip({Key? key}) : super(key: key);

  @override
  State<PatiTakip> createState() => _PatiTakipState();
}

class _PatiTakipState extends State<PatiTakip> {
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Padding(
          padding:
              EdgeInsets.only(right: 55.0), // Sağa 10 birimlik boşluk ekler
          child: Center(
            child: const Text(
              'Pati Takip Sayfası',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'aptosbold',
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      ),
      body: Container(
        color: const Color.fromARGB(255, 223, 223, 223),
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
                        builder: (context) => PatiTakipFiltrele(),
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
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('patiTakip')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const SizedBox(height: 6),
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
                                          if (favoriteIds
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
