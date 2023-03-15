import 'dart:io';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:garbage_collector/models/models.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:garbage_collector/env/env.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

class CameraScreen extends StatefulWidget {
  final bool isThrowable;
  const CameraScreen({required this.isThrowable, super.key});
  @override
  State<CameraScreen> createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  final _globalStates = Get.find<GlobalState>();
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  final int _cameraIndex = 0;

  bool _isCapture = false;
  bool _isProgress = false;
  XFile? _image;
  String _category = '';
  String _largeCategory = '';
  List<Basket?> _baskets = [null, null];

  @override
  void initState() {
    super.initState();
    _initCamera();
    _saveLocation();
  }

  Future<void> _saveLocation() async {
    final location = await Geolocator.getCurrentPosition();
    _globalStates.changeLocation(LatLng(location.latitude, location.longitude));
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[_cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _cameraController?.setFlashMode(FlashMode.off);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCapture
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: 0.4,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.dstATop,
                      ),
                      image: Image.file(File(_image!.path)).image,
                    ),
                  ),
                ),
                (_isProgress)
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('쓰레기를 분류하는 중이에요',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                            SizedBox(height: 20),
                            CircularProgressIndicator()
                          ],
                        ),
                      )
                    : Center(
                        child: TrashScreen(
                        category: _category,
                        largeCategory: _largeCategory,
                        baskets: _baskets,
                      )),
                const GoingBackButton(),
                if (!_isProgress)
                  Positioned(
                    right: 10,
                    top: 40,
                    child: GestureDetector(
                        onTap: () async {
                          final result = await Get.to(() => CategoryScreen(
                                image: _image!,
                              )) as Tuple2?;
                          if (result == null) {
                            return;
                          }
                          _category = result.item1;
                          _largeCategory = result.item2;
                          _baskets = await Basket.findBaskets(
                              _globalStates.token,
                              _globalStates.latlng.latitude,
                              _globalStates.latlng.longitude,
                              _largeCategory);

                          if (_baskets.isEmpty) {
                            _baskets = [null, null];
                          }
                          if (_baskets.length == 1) {
                            _baskets.add(null);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.refresh_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                '다시 분류하기',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ),
              ],
            )
          : Stack(
              children: [
                FutureBuilder<void>(
                  future: _initCameraControllerFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: CameraPreview(_cameraController!));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const GoingBackButton(),
                Positioned.fill(
                  bottom: 30,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await _cameraController!.takePicture().then((value) {
                            _image = value;
                          });
                          HapticFeedback.mediumImpact();

                          setState(() {
                            _isCapture = true;
                            _isProgress = true;
                          });
                          if (_image != null) {
                            Dio dio = Dio();

                            final len = await _image!.length();

                            FormData formData = FormData.fromMap({
                              "image": await MultipartFile.fromFile(
                                  _image!.path,
                                  filename: "image.jpeg"),
                            });

                            final categoryResult = await dio.get(
                              '${ENV.imageEndPoint}/garbage',
                              data: formData,
                              options: Options(
                                headers: {
                                  "Content-Type": 'multipart/form-data',
                                  "Content-Length": len,
                                },
                              ),
                            );

                            log(categoryResult.data.toString());
                            _category = categoryResult.data['predicted_type'];

                            _largeCategory = 'GENERAL';
                            if (_category == 'battery' ||
                                _category == 'glass' ||
                                _category == 'green glass' ||
                                _category == 'metal' ||
                                _category == 'plastic' ||
                                _category == 'white glass') {
                              _largeCategory = 'RECYCLE';
                            }
                            if (!widget.isThrowable) {
                              Get.back(
                                  result: Tuple2(_largeCategory, _category));
                              return;
                            }

                            _baskets = await Basket.findBaskets(
                                _globalStates.token,
                                _globalStates.latlng.latitude,
                                _globalStates.latlng.longitude,
                                _largeCategory);

                            if (_baskets.isEmpty) {
                              _baskets = [null, null];
                            }
                            if (_baskets.length == 1) {
                              _baskets.add(null);
                            }
                          }
                          setState(() {
                            _isProgress = false;
                          });
                        } catch (e, s) {
                          log(e.toString(), stackTrace: s);
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorSystem.primary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.camera,
                            color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
