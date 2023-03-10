import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/models/basket.dart';

class ReportScreen extends StatefulWidget {
  final Basket basket;
  const ReportScreen({required this.basket, super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

const List<String> reportTypes = [
  "EMPTY",
  "REPAIR",
  "INSPECTION",
];

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                opacity: 0.7,
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/images/backgroundTrashBin.png'), // 배경 이미지
              ),
            ),
            child: Center(
              child: SizedBox(
                height: Get.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.basket.basketName} 쓰레기통',
                      style: const TextStyle(
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
                    InkWell(
                      onTap: () {
                        Basket.reportBaskets(reportTypes[0], widget.basket.id);
                        Get.off(() => const ReportConfirmScreen());
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                        child: const Text(
                          '쓰레기통의 보수가 필요해요',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Basket.reportBaskets(reportTypes[1], widget.basket.id);
                        Get.off(() => const ReportConfirmScreen());
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                        child: const Text(
                          '내용물을 비워야 해요',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Basket.reportBaskets(reportTypes[2], widget.basket.id);
                        Get.off(() => const ReportConfirmScreen());
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                        child: const Text(
                          '관리자의 점검이 필요해요',
                          style: TextStyle(
                            color: Colors.black,
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
          GoingBackButton(
            func: () {
              Get.offAll(() => const HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}

class ReportConfirmScreen extends StatefulWidget {
  const ReportConfirmScreen({super.key});

  @override
  State<ReportConfirmScreen> createState() => _ReportConfirmScreenState();
}

class _ReportConfirmScreenState extends State<ReportConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                opacity: 0.7,
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/images/backgroundTrashBin.png'), // 배경 이미지
              ),
            ),
            child: Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text.rich(
                      TextSpan(
                          text: '신고 접수',
                          style: TextStyle(
                            color: ColorSystem.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '가 완료되었어요',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ]),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "환경을 지키기 위해 소중한 시간을 내어주셔서 감사해요",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 200),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Get.offAll(() => const HomeScreen());
                        });
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorSystem.primary,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "확인",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GoingBackButton(
            func: () {
              Get.offAll(() => const HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}
