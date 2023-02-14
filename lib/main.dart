import 'package:flutter/material.dart';
import 'package:garbage_collector/states/states.dart';
import 'package:get/get.dart';
import 'package:garbage_collector/screens/screens.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:garbage_collector/styles/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Firebase init
  runApp(const GarbageCollector());
}

class GarbageCollector extends StatelessWidget {
  const GarbageCollector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: child!,
      ),
      home: const SplashScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      initialBinding: BindingsBuilder(() {
        Get.put(GlobalState());
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: ColorSystem.primary,
          primary: ColorSystem.primary,
        ),
        fontFamily: 'pretendard',
      ),
    );
  }
}
