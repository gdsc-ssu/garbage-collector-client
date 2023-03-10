import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/consts/consts.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class CategoryScreen extends StatefulWidget {
  final XFile image;
  const CategoryScreen({required this.image, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.4,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.dstATop,
            ),
            image: Image.file(File(widget.image.path)).image,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: Get.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    '버리려는 쓰레기의',
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                  const Text(
                    '카테고리를 골라주세요',
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                  GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 40,
                      ),
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                      shrinkWrap: true,
                      itemCount: trashTranslate.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (_index == index) {
                                _index = -1;
                              } else {
                                _index = index;
                              }
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width * 0.3,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (_index == index)
                                          ? ColorSystem.primary
                                          : Colors.white.withOpacity(0.5)),
                                  child: Text(
                                    trashTranslate.values.toList()[index],
                                    style: TextStyle(
                                      color: (_index == index)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                  GestureDetector(
                    onTap: () {
                      if (_index == -1) {
                        return;
                      }
                      final selectedCategory =
                          trashTranslate.keys.toList()[_index];

                      String largeCategory = 'GENERAL';
                      if (selectedCategory == 'battery' ||
                          selectedCategory == 'glass' ||
                          selectedCategory == 'green glass' ||
                          selectedCategory == 'metal' ||
                          selectedCategory == 'plastic' ||
                          selectedCategory == 'white glass') {
                        largeCategory = 'RECYCLE';
                      }

                      Get.back(result: Tuple2(selectedCategory, largeCategory));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      decoration: BoxDecoration(
                        color: (_index != -1)
                            ? ColorSystem.primary
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '선택하기!',
                        style: TextStyle(
                            color:
                                (_index != -1) ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const GoingBackButton(),
          ],
        ),
      ),
    );
  }
}
