import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
import 'package:garbage_collector/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalStates = Get.find<GlobalState>();

  late final TabController _tabController;
  int _index = 1;
  bool _isPoping = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, initialIndex: 1, vsync: this);
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
      _tabController.animateTo(index);
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: (() async {
            if (_index == 1) {
              GlobalState.navigatorKey.currentState!
                  .push(MaterialPageRoute(builder: ((context) {
                return const MainMap();
              })));
              return false;
            }
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
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const CollectionScreen(),
                Navigator(
                  key: GlobalState.navigatorKey,
                  onGenerateRoute: ((settings) {
                    return MaterialPageRoute(builder: ((context) {
                      return const MainMap();
                    }));
                  }),
                ),
                const RankScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
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
