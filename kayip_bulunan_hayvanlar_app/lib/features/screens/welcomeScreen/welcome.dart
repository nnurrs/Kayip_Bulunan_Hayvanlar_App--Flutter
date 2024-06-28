import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'login.dart'; // login.dart dosyasını burada içe aktar

//bu sayfa kullanılmıyor
class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/foto.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Carousel(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.18, // İhtiyaca göre pozisyonu ayarlayın
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'PAWFIND',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'harold',
                  color: Color(0XFF783192),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: const Color(0XFF4F4944),
                  ),
                  color:
                      Colors.white.withOpacity(0.5), // Şeffaf arka plan eklendi
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.1), // Gölgelendirme rengi
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // Gölgenin yönü
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          child: const Text(
                            "Giriş Yap / Kayıt Ol",
                            style: TextStyle(
                              color: Color(0XFF783192),
                              fontFamily: 'aptosbold',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/foto.jpg', // Fotoğrafın yolunu verin
    'assets/images/kayipBulunanSayfasi.png', // Diğer fotoğraf yolları buraya eklenebilir
    'assets/images/foto.jpg',
    'assets/images/foto.jpg',
  ];

  final List<String> _captions = [
    'Bir yuva, bir sevgi... Sahiplenmek için bir adım atın!',
    'Kaybolan dostlar için umut olun!',
    'Bir Kap Mama, Sonsuz Mutluluk...',
    'Takipte kalın, umutlarına ortak olun!',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: _images.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10), // Boşluk azaltıldı
                        Text(
                          _captions[_currentIndex % _captions.length],
                          textAlign: TextAlign.center, // Yazıyı ortala
                          style: const TextStyle(
                            color: Color.fromARGB(255, 58, 45, 45),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
