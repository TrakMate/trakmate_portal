import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/utils/app_router.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 300 * 1024 * 1024;

  if (kIsWeb) {
    // Clean URLs such as /trakmate_portal/products/gateways
    // instead of hash URLs such as /#/products/gateways.
    usePathUrlStrategy();
  } else {
    // ... your existing orientation code unchanged ...
  }

  runApp(const TrakMatePortal());
}

class TrakMatePortal extends StatelessWidget {
  const TrakMatePortal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TrakMate',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
