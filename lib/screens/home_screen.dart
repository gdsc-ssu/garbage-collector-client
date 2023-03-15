import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  final int initScreenIndex;
  const HomeScreen({this.initScreenIndex = 1, super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalStates = Get.find<GlobalState>();

  int _index = 1;
  bool _isPoping = false;

  @override
  void initState() {
    super.initState();
    _globalStates.tabController = TabController(
        length: 3, initialIndex: widget.initScreenIndex, vsync: this);
    _index = widget.initScreenIndex;
  }

  void _onTapNavigator(int index) async {
    HapticFeedback.lightImpact();

    if (index == _index) return;

    if (_index == 1) {
      final bounds = await _globalStates.mapController.getVisibleRegion();
      _globalStates.changeLocation(LatLng(
          (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
          (bounds.northeast.longitude + bounds.southwest.longitude) / 2));
    }

    setState(() {
      _globalStates.tabController.animateTo(index);
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.initScreenIndex,
      child: Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: (() async {
            if (!_isPoping) {
              _isPoping = true;
              Timer(const Duration(milliseconds: 200), () {
                _isPoping = false;
              });
              showToast('한번 더 뒤로가기를 하면 종료됩니다.');
              return false;
            }

            return true;
          }),
          child: SafeArea(
            child: TabBarView(
              controller: _globalStates.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                CollectionScreen(),
                MainMap(),
                RankScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: (Platform.isAndroid || window.physicalSize.width <= 1080)
              ? 56
              : 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                spreadRadius: 2,
              ),
            ],
          ),
          child: TabBar(
            indicator: const BoxDecoration(),
            indicatorColor: null,
            onTap: _onTapNavigator,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.book_outlined,
                  color: (_index == 0) ? ColorSystem.primary : Colors.grey,
                  size: 36,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                  color: (_index == 1) ? ColorSystem.primary : Colors.grey,
                  size: 36,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.star_border,
                  color: (_index == 2) ? ColorSystem.primary : Colors.grey,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
