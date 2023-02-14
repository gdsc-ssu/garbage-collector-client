import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';

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
              final user = await _globalStates.googleAuth();
              if (user == null) {
                return;
              }
              log(user.additionalUserInfo.toString());
              log(user.credential.toString());
              log(user.user.toString());
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
      body: SingleChildScrollView(
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
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('닉네임'), Text('설명')],
                ),
              ],
            ),
            Text('주로 처리한 쓰레기'),
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
            Text('로그아웃'),
          ],
        ),
      ),
    );
  }
}
