import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/digerSahiplen.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kediSahiplen.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kopekSahiplen.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/kusSahiplen.dart';
import 'package:kayip_bulunan_hayvanlar_app/features/screens/altMenuSayfalar/sahiplenFiltrele.dart';

class Sahiplen extends StatefulWidget {
  const Sahiplen({Key? key}) : super(key: key);
  @override
  _SahiplenState createState() => _SahiplenState();
}

class _SahiplenState extends State<Sahiplen> {
  @override
  void initState() {
    super.initState();
    _checkAndMoveDocuments();
  }

  Future<void> _checkAndMoveDocuments() async {
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(Duration(days: 15));

    final foundCollection = FirebaseFirestore.instance.collection('bulunan');
    final adoptionCollection =
        FirebaseFirestore.instance.collection('sahiplen');

    final querySnapshot = await foundCollection.get();
    for (var doc in querySnapshot.docs) {
      final foundDate = (doc['createdAt'] as Timestamp).toDate();
      if (foundDate.isBefore(oneWeekAgo.add(Duration(days: 7)))) {
        final data = doc.data();
        final existingDocs = await adoptionCollection
            .where('uniqueField', isEqualTo: data['uniqueField'])
            .limit(1)
            .get();

        if (existingDocs.docs.isEmpty) {
          // Belgeyi 'sahiplen' koleksiyonuna ekle
          await adoptionCollection.add(data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(), // Geri tuşunu kaldırır
        title: Padding(
          padding:
              EdgeInsets.only(right: 55.0), // Sağa 10 birimlik boşluk ekler
          child: Center(
            child: const Text(
              'Sahiplen Sayfası',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'aptosbold',
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 223, 223, 223),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          builder: (context) => SahiplenFiltrele(),
                        ),
                      );
                    },
                    child: Text(
                      'Filtreleme',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 223, 223, 223),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF783192),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'Yeni bir dost edin!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontFamily: 'aptosbold',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Container(
                        width: 340.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffAED1CB),
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Kedi butonuna tıklandığında KediSahiplenSayfasi'na yönlendirme yap
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KediSahiplen(),
                                  ),
                                );
                              },
                              icon: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kediButon.png',
                                    width: 60,
                                    height: 100,
                                  ),
                                  Text(
                                    'Kedi',
                                    style: TextStyle(
                                      fontFamily: 'aptosbold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KopekSahiplen(),
                                  ),
                                );
                              },
                              icon: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kopekButon.png',
                                    width: 60,
                                    height: 100,
                                  ),
                                  Text(
                                    'Köpek',
                                    style: TextStyle(
                                      fontFamily: 'aptosbold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KusSahiplen(),
                                  ),
                                );
                              },
                              icon: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/kusButon.png',
                                    width: 60,
                                    height: 100,
                                  ),
                                  Text(
                                    'Kuş',
                                    style: TextStyle(
                                      fontFamily: 'aptosbold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DigerSahiplen(),
                                  ),
                                );
                              },
                              icon: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/digerButon.png',
                                    width: 60,
                                    height: 100,
                                  ),
                                  Text(
                                    'Diğer',
                                    style: TextStyle(
                                      fontFamily: 'aptosbold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'Sahiplenmeye uygun hayvanlar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'aptosbold',
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sahiplen')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data!.docs
                              .map<Widget>((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Container(
                              width: 250,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xffAED1CB),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        width: 230,
                                        height: 180,
                                        child: Image.network(
                                          data['foto'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 223, 223, 223),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data['ad'],
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "aptosbold",
                                            ),
                                          ),
                                          Text(
                                            data['il'],
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "aptosbold",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'CİNS: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['cins']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "aptoslight",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text: 'TÜR: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['tur']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "aptoslight",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text: 'RENK: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['renk']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "aptoslight",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text: 'YAŞ: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['yas']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "aptoslight",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text: 'CİNSİYET: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['cinsiyet']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: "aptoslight",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              text: 'EK NOT: ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "aptosbold",
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${data['ekNot']}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
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
                                              fontSize: 16,
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
                                                  var kullaniciData = snapshot
                                                          .data
                                                          ?.data()
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
                                                            fontFamily:
                                                                'aptosbold',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            kullaniciData[
                                                                'eposta'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                              fontFamily:
                                                                  'aptoslight',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return const Text(
                                                        'Bulunamadı');
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
                              ),
                            );
                          }).toList(),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
