import 'package:flutter/material.dart';
import 'package:garbage_collector/widgets/widgets.dart';
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
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () async {
                    final result = await globalStates.googleAuth();
                    if (result == 'SUCCESS') {
                      Get.back();
                    }
                  },
                  child: const GoogleLogin()),
              GestureDetector(
                onTap: () {},
                child: const AppleLogin(),
              ),
            ]),
      ),
    );
  }
}

class ItemCardDialog extends StatelessWidget {
  final String type;
  const ItemCardDialog({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('일반 쓰레기 카드 획득!', style: TextStyle(fontSize: 21)),
              const SizedBox(height: 10),
              Image.asset('assets/images/general.png', width: 200, height: 200),
            ]),
      ),
    );
  }
}
