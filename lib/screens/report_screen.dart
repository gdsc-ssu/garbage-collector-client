import 'package:flutter/material.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: Get.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '동작구1 쓰레기통',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text('현재 쓰레기통의 상태는 어떤가요?'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _index = 1;
                  });
                },
                child: Container(
                  width: Get.width * 0.7,
                  height: 60,
                  decoration: BoxDecoration(
                      color: (_index == 1) ? ColorSystem.primary : Colors.white,
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
                  child: const Text('쓰레기통의 보수가 필요해요'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _index = 2;
                  });
                },
                child: Container(
                  width: Get.width * 0.7,
                  height: 60,
                  decoration: BoxDecoration(
                      color: (_index == 2) ? ColorSystem.primary : Colors.white,
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
                  child: const Text('내용물을 비워야 해요'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _index = 3;
                  });
                },
                child: Container(
                  width: Get.width * 0.7,
                  height: 60,
                  decoration: BoxDecoration(
                      color: (_index == 3) ? ColorSystem.primary : Colors.white,
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
                  child: const Text('관리자의 점검이 필요해요'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}