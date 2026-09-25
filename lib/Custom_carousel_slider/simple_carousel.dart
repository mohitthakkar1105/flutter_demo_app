import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SimpleCarousel extends StatefulWidget {
  const SimpleCarousel({super.key});

  @override
  State<SimpleCarousel> createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  int currentIndex = 0;

  final List<Widget> images = [
    Image.asset("assets/ic_notification.png"),
    Image.asset("assets/dice-2.png"),
    Image.asset("assets/dice-3.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: [...images],

          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),

        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: 3,
          // effect: const ExpandingDotsEffect(
          //   activeDotColor: CupertinoColors.activeBlue,
          //   dotColor: CupertinoColors.systemGrey,
          // ),
        ),
      ],
    );
  }
}
