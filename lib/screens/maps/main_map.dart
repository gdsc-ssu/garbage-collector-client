import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:garbage_collector/widgets/widgets.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Garbage Collector',
        allowBackButton: false,
        actions: [
          GestureDetector(
            onTap: () async {
              Get.to(() => const SettingScreen());
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(right: 20),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: ColorSystem.primary,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _globalStates.mapController = controller;
              });
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition:
                CameraPosition(target: _globalStates.latlng, zoom: 16),
            markers: {
              Marker(
                  icon: BitmapDescriptor.defaultMarker,
                  markerId: MarkerId('1234'),
                  position: _globalStates.latlng,
                  onTap: () {
                    Get.dialog(
                      Dialog(
                          child: Container(
                        width: 150,
                        height: 100,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueAccent),
                            ),
                            Flexible(
                              child: Column(children: [
                                Text('선유기지'),
                                Text('이곳에서 Garbage Collection을 3회 진행했습니다.'),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.grey,
                                    ),
                                    Text('현재 위치에서 300m')
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )),
                    );
                  })
            },
          ),
          // Positioned(
          //     right: 10,
          //     bottom: 70,
          //     child: GestureDetector(
          //       onTap: () async {
          //         await _globalStates.mapController
          //             .animateCamera(CameraUpdate.zoomIn());
          //       },
          //       child: Container(
          //           height: 40,
          //           width: 40,
          //           alignment: Alignment.center,
          //           decoration: BoxDecoration(
          //               color: ColorSystem.primary,
          //               borderRadius: BorderRadius.circular(5)),
          //           child: const Text(
          //             '+',
          //             style: TextStyle(color: Colors.white, fontSize: 21),
          //           )),
          //     )),
          // Positioned(
          //     right: 10,
          //     bottom: 10,
          //     child: GestureDetector(
          //       onTap: () async {
          //         await _globalStates.mapController
          //             .animateCamera(CameraUpdate.zoomOut());
          //       },
          //       child: Container(
          //           height: 40,
          //           width: 40,
          //           alignment: Alignment.center,
          //           decoration: BoxDecoration(
          //               color: ColorSystem.primary,
          //               borderRadius: BorderRadius.circular(5)),
          //           child: const Text(
          //             '-',
          //             style: TextStyle(color: Colors.white, fontSize: 21),
          //           )),
          //     )),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const CameraScreen());
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: ColorSystem.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.change_circle_rounded,
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
