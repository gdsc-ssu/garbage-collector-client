import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  final double size;
  final String imgUrl;
  const CircularProfileImage({this.size = 80, required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          imgUrl,
          height: size,
          fit: BoxFit.cover,
        ));
  }
}
