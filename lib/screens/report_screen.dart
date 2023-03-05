import 'package:flutter/material.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/models/basket.dart';
import 'package:garbage_collector/states/global.dart';

class ReportScreen extends StatefulWidget {
  final int basketId;
  const ReportScreen({required this.basketId, super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

const List<String> reportTypes = [
  "EMPTY",
  "REPAIR",
  "INSPECTION",
];

class _ReportScreenState extends State<ReportScreen> {
  final _globalStates = Get.find<GlobalState>();
  late int basketId = widget.basketId;
  int _index = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.7,
            fit: BoxFit.fill,
            image: AssetImage('assets/images/backgroundTrashBin.png'), // 배경 이미지
          ),
        ),
        child: Center(
          child: SizedBox(
            height: Get.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '동작구1 쓰레기통',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  '현재 쓰레기통의 상태는 어떤가요?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 0;
                      Basket.reportBaskets(reportTypes[_index], basketId);
                    });
                  },
                  child: Container(
                    width: Get.width * 0.7,
                    height: 60,
                    decoration: BoxDecoration(
                        color:
                            (_index == 0) ? ColorSystem.primary : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    alignment: Alignment.center,
                    child: Text(
                      '쓰레기통의 보수가 필요해요',
                      style: TextStyle(
                        color: (_index == 0) ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 1;
                      Basket.reportBaskets(reportTypes[_index], basketId);
                    });
                  },
                  child: Container(
                    width: Get.width * 0.7,
                    height: 60,
                    decoration: BoxDecoration(
                        color:
                            (_index == 1) ? ColorSystem.primary : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    alignment: Alignment.center,
                    child: Text(
                      '내용물을 비워야 해요',
                      style: TextStyle(
                        color: (_index == 1) ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 2;
                      Basket.reportBaskets(reportTypes[_index], basketId);
                    });
                  },
                  child: Container(
                    width: Get.width * 0.7,
                    height: 60,
                    decoration: BoxDecoration(
                        color:
                            (_index == 2) ? ColorSystem.primary : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    alignment: Alignment.center,
                    child: Text(
                      '관리자의 점검이 필요해요',
                      style: TextStyle(
                        color: (_index == 2) ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
