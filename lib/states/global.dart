import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:garbage_collector/widgets/bottomsheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState extends GetxController {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Rxn<models.User> user = Rxn<models.User>();
  RxMap<String, Marker> markers = RxMap<String, Marker>({});
  RxMap<String, Marker> throwableMarkers = RxMap<String, Marker>({});
  String token = "";
  LatLng latlng = const LatLng(37.53617969250303, 126.89801745825915);

  Set<Marker> get markerList =>
      markers.values.toSet()..addAll(throwableMarkers.values.toSet());

  late GoogleMapController mapController;

  Future<void> googleAuth() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
      if (googleAccount == null) {
        showToast('구글 로그인 중 오류 발생했습니다.');
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user = await models.User.googleLogin(
        googleAccount.displayName!,
        googleAccount.email,
        credential.accessToken!,
        googleAccount.photoUrl!,
      );

      login(user);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  Future<void> loadMarkers() async {
    markers['1234'] = Marker(
        markerId: const MarkerId('1234'),
        position: const LatLng(37.4950739, 126.9600609),
        onTap: () {
          Get.bottomSheet(ThrowableMarkerBottomSheet(
              basket: models.Basket(
                  1, 'hi', 'do', 37.491736, 126.9560694, 0, DateTime.now())));
        });
  }

  void addThrowableMarker(models.Basket basket) async {
    ByteData data = await rootBundle.load('assets/icons/throwable_marker.png');
    Codec codec =
        await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 80);
    FrameInfo fi = await codec.getNextFrame();
    final markerImage =
        (await fi.image.toByteData(format: ImageByteFormat.png))!
            .buffer
            .asUint8List();

    throwableMarkers.clear();

    throwableMarkers[basket.id.toString()] = Marker(
        markerId: MarkerId(basket.id.toString()),
        icon: BitmapDescriptor.fromBytes(markerImage),
        position: LatLng(basket.lat, basket.lng),
        onTap: () {
          Get.bottomSheet(ThrowableMarkerBottomSheet(basket: basket));
        });
  }

  void login(models.User newUser) async {
    user.value = newUser;
    token = newUser.accessToken!;
    SharedPreferences.getInstance().then((pref) {
      pref.setString('accessToken', newUser.accessToken!);
      pref.setString('refreshToken', newUser.refreshToken!);
    });
  }

  Future<bool> auth() async {
    SharedPreferences.getInstance().then((pref) async {
      try {
        final accessToken = pref.getString('accessToken');
        final user = await models.User.auth(accessToken ?? '');

        login(user);
      } catch (e, s) {
        log(e.toString(), stackTrace: s);
      }
    });
    if (user.value == null) {
      return false;
    }
    return true;
  }

  void changeLocation(LatLng nextPos) {
    latlng = nextPos;
  }

  Future<void> load() async {
    // final result = await auth();

    // if (result) {
    await loadMarkers();
    // }

    Get.offAll(() => const HomeScreen());

    final location = await Geolocator.getCurrentPosition();
    latlng = LatLng(location.latitude, location.longitude);
  }

  @override
  void onInit() async {
    super.onInit();
    await load();
    // final currentRoute = Get.currentRoute;

    // if (currentRoute != '/' && currentRoute != '/SplashScreen') {
    //   return;
    // }
  }
}
