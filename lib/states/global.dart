import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GlobalState extends GetxController {
  Rxn<models.User> user = Rxn<models.User>();
  RxMap<String, Marker> markers = RxMap<String, Marker>({});
  String token = "";
  LatLng latlng = const LatLng(37.53617969250303, 126.89801745825915);

  Set<Marker> get markerList => markers.values.toSet();

  late GoogleMapController mapController;

  Future<UserCredential?> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return null;
    }
  }

  void loadMarkers() {
    markers['1234'] = Marker(
        markerId: const MarkerId('1234'),
        position: const LatLng(37.4950739, 126.9600609),
        onTap: () {
          Get.bottomSheet(
            BottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              onClosing: () {},
              enableDrag: false,
              builder: (context) {
                return SizedBox(
                  height: Get.height / 2,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blueAccent,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '숭실대 쓰레기통',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            '이곳에서 3회 Collection을 했습니다.',
                            style: TextStyle(fontSize: 15),
                          ),
                          const Text(
                            '현재 위치로부터 200m 위치',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ReportScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorSystem.primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: const [
                                  Icon(Icons.phone),
                                  Text('쓰레기통 신고하기'),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            '쓰레기통이 꽉차있거나 보수가 필요하다면 신고해주세요',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  void changeLocation(LatLng nextPos) {
    latlng = nextPos;
  }

  //TODO 데이터 로딩하는데 Future를 사용하면 async await으로 변경
  Future<void> load() async {
    loadMarkers();

    Timer(const Duration(seconds: 1), () {
      Get.offAll(() => const HomeScreen());
    });
    final location = await Location.instance.getLocation();
    if (location.latitude != null && location.longitude != null) {
      latlng = LatLng(location.latitude!, location.longitude!);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await load();
    // final currentRoute = Get.currentRoute;

    // if (currentRoute != '/' && currentRoute != '/SplashScreen') {
    //   return;
    // }
    log('hi');
  }
}
