import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({Key? key}) : super(key: key);

  @override
  _CarouselSliderPageState createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  List fruits = ["Apple", "Banana", "Cherry", "Greps", "Mango"];
  List myColors = [
    Colors.redAccent,
    Colors.amber,
    Colors.pink,
    Colors.green,
    Colors.orange
  ];

  int _initialPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Carousel Slider Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                initialPage: _initialPage,
                onPageChanged: (i, _) {
                  setState(() {});
                },
                height: 350,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayCurve: Curves.easeInOut,
                scrollDirection: Axis.horizontal,
              ),
              items: List.generate(
                fruits.length,
                (i) => Container(
                  alignment: Alignment.center,
                  color: myColors[i],
                  width: _width,
                  child: Text(
                    fruits[i],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 25,
              margin: const EdgeInsets.symmetric(horizontal: 80),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: fruits.map((e) {
                    int i = fruits.indexOf(e);

                    return InkWell(
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            (_initialPage == i) ? Colors.blue : Colors.black38,
                      ),
                      onTap: () {
                        carouselController.animateToPage(i,
                            duration: const Duration(milliseconds: 400));

                        setState(() {
                          _initialPage = i;
                        });
                      },
                    );
                  }).toList()

                  // List.generate(
                  //   fruits.length,
                  //   (i) => InkWell(
                  //     child: CircleAvatar(
                  //       radius: 10,
                  //       backgroundColor:
                  //           (_initialPage == i) ? Colors.blue : Colors.black38,
                  //     ),
                  //     onTap: () {
                  //       carouselController.animateToPage(i,
                  //           duration: const Duration(milliseconds: 400));
                  //
                  //       (_initialPage == i) ? print("Match") : print("MisMatch");
                  //     },
                  //   ),
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
