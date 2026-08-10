import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/ui/pages/main_page.dart';

Future<void> main() async {
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      // Get device info from window size to check for tablet
      final window = WidgetsBinding.instance.platformDispatcher.views.first;
      final size = window.physicalSize / window.devicePixelRatio;
      final isTablet = size.shortestSide >= 600; // common tablet threshold

      if (isTablet) {
        // Tablets → allow all orientations
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        // Phones → portrait only
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    } else {
      // Desktop platforms → allow all
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  runApp(const TrakMatePortal());
}

class TrakMatePortal extends StatelessWidget {
  const TrakMatePortal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrakMate',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
