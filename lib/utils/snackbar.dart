import 'package:get/get.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/styles/styles.dart';

void trashSnackbar() {
  final globalStates = Get.find<GlobalState>();
  Get.snackbar(
    '${trashTranslate[globalStates.trashType2]} 아이템 카드를 획득했어요!',
    '한번 확인해볼까요?',
    icon: const Icon(
      Icons.check_circle_sharp,
      size: 30,
      color: Colors.white,
    ),
    mainButton: TextButton(
      onPressed: () {
        globalStates.tabController.animateTo(1);
      },
      child: const Text(
        '확인하기',
        style: TextStyle(color: Colors.white),
      ),
    ),
    onTap: (snackbar) {
      globalStates.tabController.animateTo(1);
    },
    overlayColor: ColorSystem.primary,
    duration: const Duration(seconds: 3),
    colorText: Colors.white,
    backgroundColor: ColorSystem.primary.withOpacity(0.8),
    barBlur: 0.5,
  );
  globalStates.setTargetCategory('', '');
}
