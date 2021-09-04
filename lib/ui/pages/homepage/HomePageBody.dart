import 'package:flutter/material.dart';

import 'carousel_list_widget.dart';

List<Widget> _carousecard = [
  CarouselCard(backgroundImage: "image/NCU.jpg"),
  CarouselCard(backgroundImage: "image/NCU.jpg"),
  CarouselCard(backgroundImage: "image/NCU.jpg"),
  CarouselCard(backgroundImage: "image/NCU.jpg"),
  CarouselCard(backgroundImage: "image/NCU.jpg"),
];

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CarouselList(children: _carousecard),
    );
  }
}
