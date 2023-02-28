import 'dart:math';
import 'dart:developer';

import 'package:garbage_collector/styles/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/models/models.dart' as models;
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BeforeLogin(),
        // child: Column(
        //   children: const <Widget>[
        //     Flexible(
        //       flex: 7,
        //       child: MyInfoBox(),
        //     ),
        //     Flexible(
        //       flex: 13,
        //       child: CollectionBox(),
        //     ),
        //   ],
        // ),
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
      body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text.rich(
                TextSpan(
                    text: '재활용 쓰레기통',
                    style: TextStyle(color: ColorSystem.primary, fontSize: 24),
                    children: [
                      TextSpan(
                        text: '에 버려주세요',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () async {
                  await _globalStates.googleAuth();
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 5.0,
                        offset:
                            const Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Image.network(
                          "https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA",
                          scale: 20,
                        ),
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class MyInfoBox extends StatefulWidget {
  const MyInfoBox({super.key});

  @override
  State<MyInfoBox> createState() => _MyInfoBoxState();
}

class _MyInfoBoxState extends State<MyInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
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
              padding: const EdgeInsets.all(20),
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
                    children: [
                      const Flexible(
                        flex: 2,
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          size: 60,
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: const <Widget>[
                              Text(
                                "Eddy Sim",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "asdfwq@gmail.com",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                ),
                              )
                            ],
                          ),
                        ),
                      ), //user name
                      Flexible(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(94, 151, 85, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "라이벌 신청",
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
                    child: const Text(
                      "LV 7", //user level
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 300,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(77, 161, 64, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  )
                ],
              ),
            )
          ],
        ),
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

class CollectionBox extends StatefulWidget {
  const CollectionBox({super.key});

  @override
  State<CollectionBox> createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 30),
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
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 30,
              ),
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: 5, //쓰레기 종류 갯수
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  15,
                                ),
                              ),
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
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: const Text(
                                    "Plastic",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 230,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.7),
                                            spreadRadius: 0,
                                            blurRadius: 5.0,
                                            offset: const Offset(0,
                                                5), // changes position of shadow
                                          ),
                                        ],
                                        color: collectionInnerColors
                                            .elementAt(index),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          child: const Icon(
                                            Icons.ac_unit_outlined,
                                            size: 200,
                                          ),
                                        ),
                                        Container(
                                          child: const Text(
                                            "LV 1   콜라버려려려러",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 15,
                                    left: 60,
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 8,
                                        child: Container(
                                          width: 150,
                                          height: 7,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "$index%",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                  ),
                                  // child: TweenAnimationBuilder(
                                  //   tween: Tween<double>(begin: 0, end: 0.5),
                                  //   duration: const Duration(milliseconds: 500),
                                  //   builder: (context, value, child) =>
                                  //       LinearProgressIndicator(
                                  //     value: value,
                                  //     backgroundColor: Colors.grey,
                                  //   ),
                                  // ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        if (index == i)
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                            ),
                                            child:
                                                CollentionBottomColor(index: i),
                                          )
                                        else
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                            ),
                                            child: const Icon(
                                              Icons.circle,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () =>
                                  buttonCarouselController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.linear),
                              icon: const Icon(
                                Icons.chevron_left,
                                color: Color.fromRGBO(255, 255, 255, 0.8),
                                size: 40,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () =>
                                  buttonCarouselController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.linear),
                              icon: const Icon(
                                Icons.chevron_right,
                                color: Color.fromRGBO(255, 255, 255, 0.8),
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 380,
                    viewportFraction: 1,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CollentionBottomColor extends StatefulWidget {
  const CollentionBottomColor({super.key, required this.index});

  final int index;
  @override
  State<CollentionBottomColor> createState() => _CollentionBottomColorState();
}

class _CollentionBottomColorState extends State<CollentionBottomColor> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 15,
      color: collectionInnerColors.elementAt(widget.index),
    );
  }
}
