import 'dart:async';

import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/screens/screens.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GlobalState extends GetxController {
  Rxn<models.User> user = Rxn<models.User>();
  String token = "";
  LatLng latlng = const LatLng(37.53617969250303, 126.89801745825915);

  late GoogleMapController mapController;

  void changeLocation(LatLng nextPos) {
    latlng = nextPos;
  }

  //TODO 데이터 로딩하는데 Future를 사용하면 async await으로 변경
  void load() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  void onInit() async {
    super.onInit();
    final currentRoute = Get.currentRoute;

    if (currentRoute == '/') {
      return;
    }
    load();
  }
}
