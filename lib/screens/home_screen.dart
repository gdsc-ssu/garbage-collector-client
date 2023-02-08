import 'package:flutter/material.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:garbage_collector/styles/color.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  void _onTapNavigator(int index) async {
    HapticFeedback.lightImpact();

    setState(() {
      _tabController.animateTo(index);
    });

    _globalStates.changeLocation(
      await _globalStates.mapController.getLatLng(ScreenCoordinate(
        x: Get.width ~/ 2,
        y: (Get.height - 140) ~/ 2,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const MainMap(),
              Container(),
              const RankScreen(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: TabBar(
            onTap: _onTapNavigator,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: ColorSystem.primary,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list_alt,
                  color: ColorSystem.primary,
                  size: 30,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.wine_bar,
                  color: ColorSystem.primary,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
