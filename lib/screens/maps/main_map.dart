import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMap();
}

class _MainMap extends State<MainMap> {
  final _globalStates = Get.find<GlobalState>();

  @override
  void initState() {
    super.initState();
    _loadMarker(null);
  }

  void _loadMarker(GoogleMapController? controller) async {
    LatLngBounds bounds;
    if (controller == null) {
      bounds = LatLngBounds(
          northeast: LatLng(
            _globalStates.latlng.latitude + 0.01,
            _globalStates.latlng.longitude + 0.01,
          ),
          southwest: LatLng(
            _globalStates.latlng.latitude - 0.01,
            _globalStates.latlng.longitude - 0.01,
          ));
    } else {
      bounds = await _globalStates.mapController.getVisibleRegion();
    }

    _globalStates.loadMarkers(
        bounds.southwest.latitude - 0.001,
        bounds.southwest.longitude - 0.001,
        bounds.northeast.latitude + 0.001,
        bounds.northeast.longitude + 0.001);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _globalStates.mapController = controller;
              },
              initialCameraPosition:
                  CameraPosition(target: _globalStates.latlng, zoom: 16),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _globalStates.markerList,
              buildingsEnabled: false,
              mapToolbarEnabled: false,
            ),
            Positioned(
                right: 10,
                bottom: 90,
                child: GestureDetector(
                  onTap: () async {
                    final location = await Geolocator.getCurrentPosition();
                    await _globalStates.mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(
                            LatLng(location.latitude, location.longitude),
                            16.5));
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
                    final result =
                        await _globalStates.mapController.getVisibleRegion();

                    log('${result.southwest.latitude}, ${result.southwest.longitude}, ${result.northeast.latitude}, ${result.northeast.longitude}');
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
                  onTap: () => _loadMarker(_globalStates.mapController),
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
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const CameraScreen(isThrowable: false));
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
      ),
    );
  }
}
