import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider.builder(
          itemCount: 4,
          itemBuilder: (context, index, realIndex) {
            return Container(
              height: 100,
              width: 100,
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
            );
          },
          options: CarouselOptions()),
    );
  }
}
