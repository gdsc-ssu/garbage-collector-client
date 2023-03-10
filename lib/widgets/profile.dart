import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  final double size;
  final String imgUrl;
  const CircularProfileImage({this.size = 80, required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    if (imgUrl == '') {
      return Icon(
        Icons.account_circle_rounded,
        color: Colors.grey,
        size: size,
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
          backgroundImage: NetworkImage(
        imgUrl,
        scale: size,
      )),
    );
  }
}
