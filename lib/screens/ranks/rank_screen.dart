import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/maps/maps.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  @override
  State<RankScreen> createState() => _RankScreen();
}

class _RankScreen extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, actions: [
        GestureDetector(
          onTap: () {
            Get.snackbar(
              '새로운 쓰레기 획득!',
              '도감에 새로운 쓰레기가 등록되었어요!\n확인해볼까요?',
              icon: const Icon(
                Icons.check_circle_sharp,
                size: 30,
                color: Colors.white,
              ),
              onTap: (snackbar) {
                Get.to(() => const SettingScreen());
              },
              overlayColor: ColorSystem.primary,
              duration: const Duration(seconds: 3),
              mainButton: TextButton(
                onPressed: () {},
                child: const Text(
                  '확인하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              colorText: Colors.white,
              backgroundColor: ColorSystem.primary.withOpacity(0.8),
              barBlur: 0.5,
            );
          },
          child: const Icon(Icons.star, size: 50),
        ),
      ]),
      body: ListView.builder(
        itemCount: 100,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return Text(index.toString());
        },
      ),
    );
  }
}
