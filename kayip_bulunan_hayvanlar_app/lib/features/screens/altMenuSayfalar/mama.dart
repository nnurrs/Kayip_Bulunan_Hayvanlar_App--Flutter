import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mama Bağışı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mama(),
    );
  }
}

class Mama extends StatefulWidget {
  const Mama({Key? key}) : super(key: key);

  @override
  State<Mama> createState() => _MamaState();
}

class _MamaState extends State<Mama> {
  late GoogleMapController mapController;
  Marker? selectedMarker;
  String selectedCity = 'Tüm İller';

  final LatLng _center = const LatLng(41.015137, 28.979530);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List<Map<String, dynamic>>> _fetchMamaData() async {
    List<Map<String, dynamic>> mamaList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('mama').get();
      for (var doc in querySnapshot.docs) {
        mamaList.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching mama data: $e");
    }
    return mamaList;
  }

  void _placeMarker(LatLng latLng) {
    setState(() {
      selectedMarker = Marker(
        markerId: MarkerId("selected_location"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
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
              'Mama Bağışı Sayfası',
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: DropdownButtonFormField<String>(
                value: selectedCity,
                items: <String>[
                  'Tüm İller',
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
                ].map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'İl Seçin',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 25, right: 13),
              child: Text(
                'Siz de hayvan dostlarımız için belirli noktalara mama bırakmak ister misiniz?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'aptosbold',
                ),
              ),
            ),
            SizedBox(height: 16.0), // Boşluk eklendi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: const Color(0xffAED1CB),
                    child: Center(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _fetchMamaData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No data found');
                          } else {
                            var filteredData = snapshot.data!;
                            if (selectedCity != 'Tüm İller') {
                              filteredData = filteredData
                                  .where((mama) => mama['il'] == selectedCity)
                                  .toList();
                            }
                            if (filteredData.isEmpty) {
                              return Container(
                                color: const Color(0xffAED1CB),
                                alignment: Alignment.center,
                                child: Text(
                                  'Aranan ilde bağış noktası bulunamadığı için üzgünüz. \nBağış noktalarımız arasına aradığınız ili de eklemeye çalışacağız!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'aptosbold',
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  var mama = filteredData[index];
                                  return ListTile(
                                    title: Text(
                                      '${mama['ad']} - ${mama['il']}',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'aptosbold'),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            mapController.animateCamera(
                                              CameraUpdate.newLatLng(
                                                LatLng(
                                                  double.parse(mama['latitude']
                                                      as String), // latitude'ı ondalık sayıya dönüştür
                                                  double.parse(mama['longitude']
                                                      as String), // longitude'u ondalık sayıya dönüştür
                                                ),
                                              ),
                                            );
                                            _placeMarker(LatLng(
                                                double.parse(
                                                    mama['latitude'] as String),
                                                double.parse(mama['longitude']
                                                    as String)));
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Adres: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  fontFamily: 'aptosbold',
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  '${mama['adres'] ?? ''}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adres Tarif: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                fontFamily: 'aptosbold',
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                '${mama['adresTarif'] ?? ''}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 400,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      markers: (selectedMarker != null)
                          ? Set<Marker>.from([selectedMarker!])
                          : Set<Marker>(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
