import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMap();
}

class _MainMap extends State<MainMap> {
  final _globalStates = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _globalStates.mapController = controller;
              });
            },
            initialCameraPosition:
                CameraPosition(target: _globalStates.latlng, zoom: 16),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _globalStates.markerList,
          ),
          Positioned(
              right: 10,
              bottom: 90,
              child: GestureDetector(
                onTap: () async {
                  _globalStates.loadMarkers();
                  final location = await Location.instance.getLocation();
                  if (location.latitude == null || location.longitude == null) {
                    showToast('현재 위치를 읽는 데 오류가 발생했습니다.');
                    return;
                  }
                  await _globalStates.mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(
                          LatLng(location.latitude!, location.longitude!), 17));
                },
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5))),
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.white,
                      size: 24,
                    )),
              )),
          Positioned(
              right: 10,
              bottom: 50,
              child: GestureDetector(
                onTap: () async {
                  await _globalStates.mapController
                      .animateCamera(CameraUpdate.zoomIn());
                },
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5))),
                    child: const Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    )),
              )),
          Positioned(
            right: 10,
            bottom: 10,
            child: GestureDetector(
                onTap: () async {
                  await _globalStates.mapController
                      .animateCamera(CameraUpdate.zoomOut());
                },
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5))),
                    child: const Text(
                      '-',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ))),
          ),
          Positioned(
            right: 10,
            bottom: 130,
            child: GestureDetector(
                onTap: () async {
                  //TODO 터치 시 검색
                },
                child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorSystem.primary,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5))),
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 24,
                    ))),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.to(() => const SettingScreen());
              },
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: ColorSystem.primary,
                    size: 24,
                  )),
            ),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  GlobalState.navigatorKey.currentState!
                      .push(MaterialPageRoute(builder: ((context) {
                    return const CameraScreen();
                  })));
                  // Get.to(() => const CameraScreen());
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorSystem.primary,
                    ),
                    child: const Icon(
                      Icons.camera,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
