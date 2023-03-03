import 'package:flutter/material.dart';
import 'package:garbage_collector/models/models.dart';
import 'package:garbage_collector/screens/maps/maps.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:garbage_collector/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/styles/color.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  @override
  State<RankScreen> createState() => _RankScreen();
}

class _RankScreen extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                ColorSystem.primary,
                Colors.white,
              ],
              stops: [
                0.6,
                1
              ]),
        ),
        child: Column(
          children: [
            const TopThreeRanks(),
            Flexible(
              flex: 6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const RankListView(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // Get.bottomSheet(MarkerBottomSheet(
          //     basket: Basket(
          //         1, 'hi', 'do', 37.491736, 126.9560694, 0, DateTime.now())));
          Get.bottomSheet(ThrowableMarkerBottomSheet(
              basket: Basket(
                  1, 'hi', 'do', 37.491736, 126.9560694, 0, DateTime.now())));
        },
        child: Container(
          color: Colors.white,
          child: Icon(Icons.ac_unit_rounded),
        ),
      ),
    );
  }
}

class TopThreeRanks extends StatelessWidget {
  const TopThreeRanks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(252, 208, 19, 1),
            ),
            child: const Text(
              "Weekly best!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        size: 80,
                      ),
                      const Text(
                        "최상원",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "200",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(192, 192, 192, 1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset: const Offset(5, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "2nd",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        size: 80,
                      ),
                      const Text(
                        "최상원",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "200",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 199, 0, 1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset: const Offset(5, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "1st",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        size: 80,
                      ),
                      const Text(
                        "최상원",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "200",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(240, 151, 101, 1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5.0,
                              offset: const Offset(5, 0),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "3rd",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class RankListView extends StatefulWidget {
  const RankListView({super.key});

  @override
  State<RankListView> createState() => _RankListViewState();
}

class _RankListViewState extends State<RankListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          if (index < 2) return const SizedBox.shrink();
          return Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 2, color: Color.fromRGBO(240, 242, 244, 1)))),
            width: 100,
            height: 60,
            child: Center(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 70,
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // color: Color.fromRGBO(153, 153, 153, 1),
                    child: const Icon(
                      Icons.account_circle_rounded,
                      color: Color.fromRGBO(190, 190, 190, 1),
                      size: 40,
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.fromLTRB(0, 0, 150, 0),
                    width: 200,
                    child: const Text(
                      '최상원',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: const Text(
                      '200',
                      style: TextStyle(
                        color: Color.fromRGBO(153, 153, 153, 1),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
