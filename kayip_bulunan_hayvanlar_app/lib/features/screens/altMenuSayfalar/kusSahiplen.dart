import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KusSahiplen extends StatefulWidget {
  const KusSahiplen({Key? key}) : super(key: key);

  @override
  State<KusSahiplen> createState() => _KusSahiplenState();
}

class _KusSahiplenState extends State<KusSahiplen> {
  final CollectionReference _sahiplenCollection =
      FirebaseFirestore.instance.collection('sahiplen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kuş Sahiplen',
          style: TextStyle(fontFamily: 'aptosbold'),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      ),
      backgroundColor: const Color.fromARGB(
          255, 223, 223, 223), // Sayfanın arka plan rengini kırmızı yap
      body: FutureBuilder<QuerySnapshot>(
        future: _sahiplenCollection.where('cins', isEqualTo: 'Kuş').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Sahiplenmeye uygun kuş bulunamadı.'));
          }

          final kuslar = snapshot.data!.docs;

          return ListView.builder(
            itemCount: kuslar.length,
            itemBuilder: (context, index) {
              final kus = kuslar[index];
              final ad = kus['ad'] ?? 'Bilinmiyor';
              final il = kus['il'] ?? 'Bilinmiyor';
              final cins = kus['cins'] ?? 'Bilinmiyor';
              final cinsiyet = kus['cinsiyet'] ?? 'Bilinmiyor';
              final ekNot = kus['ekNot'] ?? 'Yok';
              final tur = kus['tur'] ?? 'Bilinmiyor';
              final renk = kus['renk'] ?? 'Bilinmiyor';
              final foto = kus['foto'] ?? '';
              final yas = kus['yas'] ?? 'Bilinmiyor';

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xffAED1CB),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (foto.isNotEmpty)
                      Image.network(
                        foto,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 8.0),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 223, 223, 223),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$ad',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'aptosbold')),
                          Text('$il',
                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: 'aptosbold')),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'CİNS:   ', // Başlık
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$cins', // Değer
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'TÜR:   ',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$tur',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'RENK:   ',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$renk',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'YAŞ:   ',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$yas',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'CİNSİYET:   ',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$cinsiyet',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: 'EK NOT:   ',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "aptosbold",
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$ekNot',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "aptoslight",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
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
                                .doc((kus.data() as Map)['userId'])
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Hata: ${snapshot.error}');
                                } else {
                                  var kullaniciData = snapshot.data?.data()
                                      as Map<String, dynamic>?;

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
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
