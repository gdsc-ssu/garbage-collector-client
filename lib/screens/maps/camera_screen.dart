import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/widgets/widgets.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;

  bool isCapture = false;
  File? captureImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[cameraIndex],
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
      body: isCapture
          ? Stack(
              children: [
                /// 촬영 된 이미지 출력
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
                      image: MemoryImage(captureImage!.readAsBytesSync()),
                    ),
                  ),
                ),
                const Center(child: TrashScreen()),

                const Positioned(
                  left: 10,
                  top: 20,
                  child: GoingBackButton(),
                ),

                // Flexible(
                //   flex: 2,
                //   fit: FlexFit.tight,
                //   child: InkWell(
                //     onTap: () {
                //       /// 재촬영 선택시 카메라 삭제 및 상태 변경
                //       captureImage!.delete();
                //       captureImage = null;
                //       setState(() {
                //         isCapture = false;
                //       });
                //     },
                //     child: SizedBox(
                //       width: double.infinity,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: const [
                //           Icon(
                //             Icons.arrow_back,
                //             color: Colors.white,
                //           ),
                //           SizedBox(height: 16.0),
                //           Text(
                //             "다시 찍기",
                //             style: TextStyle(
                //                 fontSize: 16.0,
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
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
                            captureImage = File(value.path);
                          });

                          /// 화면 상태 변경 및 이미지 저장
                          setState(() {
                            isCapture = true;
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
