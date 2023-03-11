import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/states/states.dart';

class LoginCheckerDialog extends StatelessWidget {
  final globalStates = Get.find<GlobalState>();
  LoginCheckerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('쓰레기 버리기 기능을 사용하려면', style: TextStyle(fontSize: 15)),
              const Text('로그인을 해야 합니다!', style: TextStyle(fontSize: 15)),
              TextButton(
                  onPressed: () async {
                    final result = await globalStates.googleAuth();
                    if (result == 'SUCCESS') {
                      Get.back();
                    }
                  },
                  child: const Text('구글 로그인')),
              TextButton(onPressed: () {}, child: const Text('애플 로그인'))
            ]),
      ),
    );
  }
}
