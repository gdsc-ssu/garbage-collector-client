import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  final _globalStates = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '설정',
        actions: [
          GestureDetector(
            onTap: () async {
              await _globalStates.googleAuth();
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(),
              ),
              child: Text('로그인'),
            ),
          ),
        ],
      ),
      body: (_globalStates.user.value != null)
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: Image.network(
                                        _globalStates.user.value!.profileImg!)
                                    .image)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(_globalStates.user.value!.nickname),
                          Text('설명')
                        ],
                      ),
                    ],
                  ),
                  const Text('주로 처리한 쓰레기'),
                  TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 0.5),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) =>
                          LinearProgressIndicator(
                            value: value,
                            backgroundColor: Colors.grey,
                          )),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 10, bottom: 50),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('플라스틱 쓰레기'),
                          Text('처리횟수 : ${_globalStates.user.value!.plastic}회'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 10, bottom: 50),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('플라스틱 쓰레기'),
                          Text('처리횟수 : 100회'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(right: 10, bottom: 50),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('플라스틱 쓰레기'),
                          Text('처리횟수 : 100회'),
                        ],
                      ),
                    ],
                  ),
                  Text('개발자에게 문의하기'),
                  GestureDetector(
                    onTap: () async {},
                    child: Text('로그아웃'),
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
