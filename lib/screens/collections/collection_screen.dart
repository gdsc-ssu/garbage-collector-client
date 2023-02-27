import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: const <Widget>[
            Flexible(
              flex: 7,
              child: MyInfoBox(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
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
