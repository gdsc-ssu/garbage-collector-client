import 'dart:math';

import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final _globalStates = Get.find<GlobalState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (_globalStates.user.value == null)
            ? const BeforeLogin()
            : Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.33,
                    child: const MyInfoBox(),
                  ),
                  const CollectionBox(),
                ],
              ),
      ),
    );
  }
}

class BeforeLogin extends StatefulWidget {
  const BeforeLogin({super.key});

  @override
  State<BeforeLogin> createState() => _BeforeLoginState();
}

class _BeforeLoginState extends State<BeforeLogin> {
  final _globalStates = Get.find<GlobalState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text.rich(
              TextSpan(
                  text: '로그인',
                  style: TextStyle(
                    color: ColorSystem.primary,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' 후',
                      style: TextStyle(color: Colors.black),
                    )
                  ]),
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: const Text(
                "이용할 수 있습니다.",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await _globalStates.googleAuth().then((value) {
                  Get.offAll(() => const HomeScreen(initScreenIndex: 0));
                });
              },
              child: const GoogleLogin(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyInfoBox extends StatefulWidget {
  const MyInfoBox({super.key});

  @override
  State<MyInfoBox> createState() => _MyInfoBoxState();
}

class _MyInfoBoxState extends State<MyInfoBox> {
  final _globalStates = Get.find<GlobalState>();
  int _totalLevel = 0;
  int _percent = 0;

  @override
  void initState() {
    super.initState();
    final user = _globalStates.user.value!;
    int total =
        user.general + user.plastic + user.can + user.glass + user.paper;

    _totalLevel = (total ~/ 10) + 4;
    _percent = (total % 10);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Get.height * 0.01),
            child: const Text(
              "My Info",
              style: TextStyle(
                color: Color.fromRGBO(94, 151, 85, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 150,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: CircularProfileImage(
                            imgUrl: _globalStates.user.value!.profileImg!,
                            size: 46,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _globalStates.user.value!.nickname ?? '익명',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              _globalStates.user.value!.email,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(153, 153, 153, 1),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(94, 151, 85, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          _globalStates.signOut().then((value) {
                            Get.offAll(
                                () => const HomeScreen(initScreenIndex: 0));
                          });

                          setState(() {});
                        },
                        child: const Center(
                          child: Text(
                            "로그아웃",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Lv $_totalLevel',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: _percent / 10),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) => LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey,
                        )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

const List<Color> collectionInnerColors = <Color>[
  Color.fromRGBO(30, 84, 165, 1),
  Color.fromRGBO(255, 183, 43, 1),
  Color.fromRGBO(6, 21, 155, 1),
  Color.fromRGBO(234, 140, 140, 1),
  Color.fromRGBO(94, 151, 85, 1),
];

const List<Color> collectionOuterTopLeftColors = <Color>[
  Color.fromRGBO(207, 224, 248, 1),
  Color.fromRGBO(255, 231, 148, 1),
  Color.fromRGBO(208, 204, 253, 1),
  Color.fromRGBO(255, 220, 220, 1),
  Color.fromRGBO(207, 238, 202, 1),
];
const List<Color> collectionOuterBottomRightColors = <Color>[
  Color.fromRGBO(66, 130, 226, 1),
  Color.fromRGBO(255, 231, 148, 1),
  Color.fromRGBO(93, 79, 250, 1),
  Color.fromRGBO(234, 140, 140, 1),
  Color.fromRGBO(94, 151, 85, 1)
];

final List<Image> collectionTrashCharacter = [
  TrashCharacter.plastic,
  TrashCharacter.general,
  TrashCharacter.glass,
  TrashCharacter.paper,
  TrashCharacter.can,
];

const List<String> collectionName = [
  "Plastic",
  "General",
  "Glass",
  "Paper",
  "Can",
];

class CollectionBox extends StatefulWidget {
  const CollectionBox({super.key});

  @override
  State<CollectionBox> createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  int _indicatorIndex = 0;
  final int _collectionDurationValue = 300;
  final CarouselController _buttonCarouselController = CarouselController();

  Widget _indicator(int curIndex) => Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          duration: const Duration(milliseconds: 100),
          activeIndex: curIndex,
          count: 5,
          effect: WormEffect(
              dotHeight: 15,
              dotWidth: 15,
              activeDotColor: collectionInnerColors[curIndex],
              dotColor: Colors.white.withOpacity(0.6)),
        ),
      );

  // Widget imageSlider(path, index) => Container(
  //       width: double.infinity,
  //       height: Get.height * 0.2,
  //       color: Colors.grey,
  //       child: Image.asset(path, fit: BoxFit.cover),
  //     );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const Text(
              "Collection",
              style: TextStyle(
                color: Color.fromRGBO(94, 151, 85, 1),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 340,
            child: Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: _buttonCarouselController,
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    double randomNumber = Random().nextDouble();
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.9),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset: const Offset(1, 5),
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            colors: [
                              collectionOuterTopLeftColors[index],
                              collectionOuterBottomRightColors[index],
                            ],
                            stops: const [0.1, 1],
                          ),
                        ),
                        child: Column(children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    collectionName[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  height: 200,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 0,
                                        blurRadius: 5.0,
                                        offset: const Offset(1, 5),
                                      ),
                                    ],
                                    color:
                                        collectionInnerColors.elementAt(index),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 170,
                                        child: collectionTrashCharacter[index],
                                      ),
                                      Text(
                                        () {
                                          if (index == 0) {
                                            return "Lv 2  방그레";
                                          }
                                          if (index == 1) {
                                            return "Lv 3  날버리지마";
                                          }
                                          if (index == 2) {
                                            return "Lv 1  비타솔챌";
                                          }
                                          if (index == 3) {
                                            return "Lv 2  밀키밀키";
                                          }
                                          if (index == 4) {
                                            return "Lv 4  콜라버려러러";
                                          }
                                          return "LV ?  최강의 쓰레기";
                                        }(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                      width: 150,
                                      child: TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0, end: randomNumber),
                                          duration:
                                              const Duration(milliseconds: 500),
                                          builder: (context, value, child) =>
                                              LinearProgressIndicator(
                                                value: value,
                                                backgroundColor: Colors.grey,
                                              )),
                                    ),
                                    Text(
                                      "${(randomNumber * 100).toInt()}%",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                _indicator(_indicatorIndex),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (pageindex, reason) => setState(() {
                      _indicatorIndex = pageindex;
                    }),
                    height: Get.height * 0.415,
                    viewportFraction: 1,
                  ),
                ),
                Positioned.fill(
                  right: 20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => _buttonCarouselController.nextPage(
                          duration:
                              Duration(milliseconds: _collectionDurationValue),
                          curve: Curves.linear),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  left: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => _buttonCarouselController.previousPage(
                          duration:
                              Duration(milliseconds: _collectionDurationValue),
                          curve: Curves.linear),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
