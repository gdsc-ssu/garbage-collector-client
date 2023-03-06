import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/models/models.dart';

class MarkerBottomSheet extends StatefulWidget {
  final Basket basket;
  const MarkerBottomSheet({required this.basket, super.key});

  @override
  State<MarkerBottomSheet> createState() => _MarkerBottomSheetState();
}

class _MarkerBottomSheetState extends State<MarkerBottomSheet> {
  late Basket _basket;
  double distance = 0;

  @override
  void initState() {
    super.initState();
    _basket = widget.basket;
    Geolocator.getCurrentPosition().then((location) {
      distance = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        _basket.lat,
        _basket.lng,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      onClosing: () {},
      enableDrag: false,
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image:
                          Image.asset('assets/images/trash_image.png').image),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _basket.basketName,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        '현재 위치로부터 ${distance.toInt()}m',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ReportScreen(basketId: _basket.id));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.phone),
                          Text('쓰레기통 신고하기'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '쓰레기통이 꽉차있거나 보수가 필요하다면 신고해주세요',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class ThrowableMarkerBottomSheet extends StatefulWidget {
  final Basket basket;
  const ThrowableMarkerBottomSheet({required this.basket, super.key});

  @override
  State<ThrowableMarkerBottomSheet> createState() =>
      _ThrowableMarkerBottomSheetState();
}

class _ThrowableMarkerBottomSheetState
    extends State<ThrowableMarkerBottomSheet> {
  late Basket _basket;
  double distance = 0;

  @override
  void initState() {
    super.initState();
    _basket = widget.basket;
    Geolocator.getCurrentPosition().then((location) {
      distance = Geolocator.distanceBetween(
          location.latitude, location.longitude, _basket.lat, _basket.lng);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      onClosing: () {},
      enableDrag: false,
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image:
                            Image.asset('assets/images/trash_image.png').image),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _basket.basketName,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        '현재 위치로부터 ${distance.toInt()}m',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        '플라스틱 아이템 카드를 획득했어요!',
                        '한번 확인해볼까요?',
                        icon: const Icon(
                          Icons.check_circle_sharp,
                          size: 30,
                          color: Colors.white,
                        ),
                        mainButton: TextButton(
                          onPressed: () {
                            Get.to(() => const SettingScreen());
                          },
                          child: const Text(
                            '확인하기',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: (snackbar) {
                          Get.to(() => const SettingScreen());
                        },
                        overlayColor: ColorSystem.primary,
                        duration: const Duration(seconds: 3),
                        colorText: Colors.white,
                        backgroundColor: ColorSystem.primary.withOpacity(0.8),
                        barBlur: 0.5,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.phone),
                          Text('쓰레기 버리기'),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
