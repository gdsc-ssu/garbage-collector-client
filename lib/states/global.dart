import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:garbage_collector/env/env.dart';
import 'package:garbage_collector/widgets/bottomsheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/screens/screens.dart';
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
  String trashType1 = '';
  String trashType2 = '';
  late LatLng latlng;
  late TabController tabController;

  Set<Marker> get markerList =>
      markers.values.toSet()..addAll(throwableMarkers.values.toSet());

  late GoogleMapController mapController;

  Future<String> googleAuth() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
      if (googleAccount == null) {
        showToast('구글 로그인 중 오류 발생했습니다.');
        return 'FAIL';
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
      return 'SUCCESS';
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
    return 'FAIL';
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    user.value = null;
  }

  Future<void> loadMarkers(
      double lat1, double lng1, double lat2, double lng2) async {
    final markerImage = await markerImageTransform(false);
    markers.clear();

    List<models.Basket> baskets =
        await models.Basket.rangeBaskets(lat1, lng1, lat2, lng2);

    for (var basket in baskets) {
      markers[basket.id.toString()] = Marker(
          markerId: MarkerId(basket.id.toString()),
          icon: BitmapDescriptor.fromBytes(markerImage),
          position: LatLng(basket.lat, basket.lng),
          onTap: () {
            Get.bottomSheet(MarkerBottomSheet(
              basket: basket,
              isThrowable: false,
            ));
          });
    }
  }

  void addThrowableMarker(models.Basket basket) async {
    final markerImage = await markerImageTransform(true);

    throwableMarkers.clear();
    throwableMarkers[basket.id.toString()] = Marker(
        markerId: MarkerId(basket.id.toString()),
        icon: BitmapDescriptor.fromBytes(markerImage),
        position: LatLng(basket.lat, basket.lng),
        onTap: () {
          Get.bottomSheet(MarkerBottomSheet(basket: basket, isThrowable: true));
        });
  }

  void login(models.User newUser) async {
    user.value = newUser;
    token = newUser.accessToken!;
    SharedPreferences.getInstance().then((pref) {
      pref.setString('accessToken', newUser.accessToken!);
    });
  }

  void setTargetCategory(String type1, String type2) {
    trashType1 = type1;
    trashType2 = type2.toUpperCase();
  }

  Future<bool> auth() async {
    SharedPreferences.getInstance().then((pref) async {
      try {
        final accessToken = pref.getString('accessToken');
        final user = await models.User.auth(accessToken ?? '');

        login(user);
      } catch (e, s) {
        if (e is! UnauthorisedException) {
          log(e.toString(), stackTrace: s);
        }
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
    await auth();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      await Geolocator.requestPermission();
    }

    await Geolocator.getCurrentPosition().then((location) {
      latlng = LatLng(location.latitude, location.longitude);

      Get.offAll(() => const HomeScreen());
    });
  }

  @override
  void onInit() async {
    super.onInit();

    await load();
  }
}
