import 'dart:ui';

import 'package:flutter/services.dart';

Future<Uint8List> markerImageTransform(bool isThrowable) async {
  String trashUrl = 'assets/icons/normal_marker.png';
  if (isThrowable) {
    trashUrl = 'assets/icons/throwable_marker.png';
  }
  ByteData data = await rootBundle.load(trashUrl);

  Codec codec =
      await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 120);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
