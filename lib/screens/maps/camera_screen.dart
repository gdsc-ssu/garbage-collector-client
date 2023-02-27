import 'dart:io';
import 'dart:developer';
// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:garbage_collector/env/env.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
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

  @override
  void initState() {
    super.initState();
    _initCamera();
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
                    ? const Center(child: CircularProgressIndicator())
                    : Center(child: TrashScreen(category: _category)),
                const Positioned(
                  left: 10,
                  top: 20,
                  child: GoingBackButton(),
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
                const Positioned(
                  left: 10,
                  top: 20,
                  child: GoingBackButton(),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await _cameraController!.takePicture().then((value) {
                            _image = value;
                          });

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

                            // final result = await http.post(
                            //     Uri.parse(
                            //         '${ENV.apiEndpoint}/basket/recommend'),
                            //     headers: {
                            //       "authorization": _globalStates.token
                            //     },
                            //     body: {
                            //       "lat": _globalStates.latlng.latitude,
                            //       "lng": _globalStates.latlng.longitude,
                            //       "type": _category
                            //     });
                          }
                          setState(() {
                            _isProgress = false;
                          });
                        } catch (e, s) {
                          log(e.toString(), stackTrace: s);
                        }
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
