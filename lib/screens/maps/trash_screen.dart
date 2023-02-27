import 'package:flutter/material.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/consts/consts.dart';

class TrashScreen extends StatefulWidget {
  final String category;
  const TrashScreen({
    required this.category,
    super.key,
  });

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          trashTranslate[widget.category] ?? '일반 쓰레기',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        const Text.rich(
          TextSpan(
              text: '재활용 쓰레기통',
              style: TextStyle(color: ColorSystem.primary, fontSize: 24),
              children: [
                TextSpan(
                  text: '에 버려주세요',
                  style: TextStyle(color: Colors.white),
                )
              ]),
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20),
        const Text(
          '내 주변 쓰레기통',
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _index = 1;
            });
          },
          child: Container(
            width: Get.width * 0.8,
            height: 80,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (_index == 1) ? ColorSystem.primary : Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '몰루',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '상도로',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text('170M'),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _index = 2;
            });
          },
          child: Container(
            width: Get.width * 0.8,
            height: 80,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (_index == 2) ? ColorSystem.primary : Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '몰루',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '상도로',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text('170M'),
                  ],
                )
              ],
            ),
          ),
        ),
        if (_index != 0)
          GestureDetector(
            onTap: () {
              GlobalState.navigatorKey.currentState!
                  .push(MaterialPageRoute(builder: ((context) {
                return const MainMap();
              })));
            },
            child: Container(
              width: Get.width * 0.5,
              height: 40,
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
