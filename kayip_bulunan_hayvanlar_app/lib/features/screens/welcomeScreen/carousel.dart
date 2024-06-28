import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//bu sayfa da kullanılmıyor
class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                ),
                items: [
                  Padding(
                    padding: const EdgeInsets.all(
                        5.0), // Apply 10px padding on all sides
                    child: Image.asset(
                      'assets/images/foto.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        5.0), // Apply 10px padding on all sides
                    child: Image.asset(
                      'assets/images/kayipBulunanSayfasi.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        5.0), // Apply 10px padding on all sides
                    child: Image.asset(
                      'assets/images/foto.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        5.0), // Apply 10px padding on all sides
                    child: Image.asset(
                      'assets/images/foto.jpg',
                      fit: BoxFit.cover,
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
