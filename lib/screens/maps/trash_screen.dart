import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:garbage_collector/consts/consts.dart';
import 'package:garbage_collector/models/models.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrashScreen extends StatefulWidget {
  final String category;
  final String largeCategory;
  final List<Basket?> baskets;

  const TrashScreen({
    required this.category,
    required this.largeCategory,
    required this.baskets,
    super.key,
  });

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  final _globalStates = Get.find<GlobalState>();
  int _index = 0;

  Widget _basketSelector(Basket? basket, int index) {
    if (basket == null) {
      return Container(
        width: Get.width * 0.8,
        height: 80,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (_index == index) ? ColorSystem.primary : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '쓰레기통이 없습니다.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              '쓰레기통이 없습니다.',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    double distance = Geolocator.distanceBetween(_globalStates.latlng.latitude,
        _globalStates.latlng.longitude, basket.lat, basket.lng);

    return Container(
      width: Get.width * 0.8,
      height: 80,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: (_index == index) ? ColorSystem.primary : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            basket.basketName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                basket.detailAddress,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text('${distance.toInt()} M'),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${trashTranslate[widget.category] ?? '일반'} 쓰레기',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        Text.rich(
          TextSpan(
              text: '${widget.largeCategory == 'RECYCLE' ? '재활용' : '일반'} 쓰레기통',
              style: const TextStyle(color: ColorSystem.primary, fontSize: 24),
              children: const [
                TextSpan(
                  text: '에 버려주세요',
                  style: TextStyle(color: Colors.white),
                )
              ]),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
        const Text(
          '내 주변 쓰레기통',
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _index = 0;
            });
          },
          child: _basketSelector(widget.baskets[0], 0),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _index = 1;
            });
          },
          child: _basketSelector(widget.baskets[1], 1),
        ),
        if (_index != -1)
          GestureDetector(
            onTap: () {
              final selectedBasket = widget.baskets[_index];
              if (selectedBasket != null) {
                _globalStates.addThrowableMarker(selectedBasket);
                _globalStates.mapController.animateCamera(
                  CameraUpdate.newLatLng(
                      LatLng(selectedBasket.lat, selectedBasket.lng)),
                );
              }
              _globalStates.setTargetCategory(
                  widget.largeCategory, widget.category.toUpperCase());

              Get.offAll(() => const HomeScreen());
            },
            child: Container(
              width: Get.width * 0.5,
              height: 40,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '길찾기',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    color: ColorSystem.primary,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
