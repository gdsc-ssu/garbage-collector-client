import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/models/models.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/widgets/widgets.dart';

class MarkerBottomSheet extends StatefulWidget {
  final Basket basket;
  final bool isThrowable;
  const MarkerBottomSheet(
      {required this.basket, required this.isThrowable, super.key});

  @override
  State<MarkerBottomSheet> createState() => _MarkerBottomSheetState();
}

class _MarkerBottomSheetState extends State<MarkerBottomSheet> {
  final _globalStates = Get.find<GlobalState>();
  double distance = 0;

  @override
  void initState() {
    super.initState();

    Geolocator.getCurrentPosition().then((location) {
      distance = Geolocator.distanceBetween(location.latitude,
          location.longitude, widget.basket.lat, widget.basket.lng);
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
          height: Get.height * 0.35,
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
                    widget.basket.basketName,
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
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      if (distance > 100) {
                        showToast('너무 멀리서 시도중입니다. 가까이에서 시도해주세요.');
                        return;
                      }
                      if (_globalStates.user.value == null) {
                        await Get.dialog(LoginCheckerDialog());
                        return;
                      }
                      if (!widget.isThrowable) {
                        final result = await Get.to(
                            () => const CameraScreen(isThrowable: false));
                        if (result == null) {
                          return;
                        }
                        if (result == 'SUCCESS') {
                          await widget.basket.throwTrash(
                              _globalStates.token,
                              _globalStates.trashType1,
                              _globalStates.trashType2);
                        }
                      }
                      trashSnackbar();
                    },
                    child: Container(
                      width: 160,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (distance < 100)
                            ? ColorSystem.primary
                            : Colors.grey,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.delete),
                          Text('쓰레기 버리기'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ReportScreen(basket: widget.basket));
                    },
                    child: Container(
                      width: 160,
                      height: 40,
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: const Icon(
                              Icons.phone,
                              size: 20,
                            ),
                          ),
                          const Text('쓰레기통 신고하기'),
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
