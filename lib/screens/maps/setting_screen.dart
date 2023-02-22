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
              try {
                final googleUser = await _globalStates.googleAuth();

                if (googleUser == null) {
                  showToast('구글 로그인 중 오류 발생했습니다.');
                  return;
                }
                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;

                final credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                final user = await models.User.googleLogin(
                  googleUser.displayName!,
                  googleUser.email,
                  credential.accessToken!,
                  googleUser.photoUrl!,
                );

                _globalStates.login(user);
                setState(() {});
              } catch (e, s) {
                log(e.toString(), stackTrace: s);
              }
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
