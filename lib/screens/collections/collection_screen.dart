import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
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
                children: <Widget>[
                  SizedBox(
                    height: Get.height * 0.33,
                    child: MyInfoBox(),
                  ),
                  SizedBox(
                    height: Get.height * 0.53,
                    child: CollectionBox(),
                  ),
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
      body: Container(
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
                await _globalStates.googleAuth();
                setState(() {});
                if (_globalStates.user.value != null) {
                  Get.offAll(() => const HomeScreen());
                }
              },
              child: Container(
                height: 70,
                width: Get.width * 1,
                child: const googleLogin(),
              ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
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
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
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
                          child: GestureDetector(
                            onTap: () async {
                              await _globalStates.signOut();
                              setState(() {
                                Get.offAll(() => const HomeScreen());
                              });
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

final List<Image> collectionTrashCharacter = [
  TrashCharacter.plastic,
  TrashCharacter.general,
  TrashCharacter.glass,
  TrashCharacter.milk,
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
  int indicatorIndex = 0;
  final collectionDurationValue = 300;
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: Get.height * 0.02),
              child: const Text(
                "Collection",
                style: TextStyle(
                  color: Color.fromRGBO(94, 151, 85, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      carouselController: buttonCarouselController,
                      itemCount: 5, //쓰레기 종류 갯수
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height * 0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.9),
                                      spreadRadius: 0,
                                      blurRadius: 5.0,
                                      offset: const Offset(
                                          1, 5), // changes position of shadow
                                    ),
                                  ],
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
                                        top: 5,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        collectionName[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: Get.height * 0.26,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                spreadRadius: 0,
                                                blurRadius: 5.0,
                                                offset: const Offset(1,
                                                    5), // changes position of shadow
                                              ),
                                            ],
                                            color: collectionInnerColors
                                                .elementAt(index),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.24,
                                              child: collectionTrashCharacter[
                                                  index],
                                            ),
                                            const SizedBox(
                                              child: Text(
                                                "LV 1   콜라버려려려러",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: Get.height * 0.01,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () =>
                                      buttonCarouselController.previousPage(
                                          duration: Duration(
                                              milliseconds:
                                                  collectionDurationValue),
                                          curve: Curves.linear),
                                  child: const Icon(
                                    Icons.chevron_left,
                                    color: Color.fromRGBO(255, 255, 255, 0.8),
                                    size: 40,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                // margin: EdgeInsets.only(right: 6),
                                child: GestureDetector(
                                  onTap: () =>
                                      buttonCarouselController.nextPage(
                                          duration: Duration(
                                              milliseconds:
                                                  collectionDurationValue),
                                          curve: Curves.linear),
                                  child: const Icon(
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
                        onPageChanged: (pageindex, reason) => setState(() {
                          indicatorIndex = pageindex;
                        }),
                        height: Get.height * 0.415,
                        viewportFraction: 1,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: indicator(indicatorIndex))
                  ],
                ),
              ),
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

Widget imageSlider(path, index) => Container(
      width: double.infinity,
      height: Get.height * 0.2,
      color: Colors.grey,
      child: Image.asset(path, fit: BoxFit.cover),
    );

Widget indicator(int curIndex) => Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.025),
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
