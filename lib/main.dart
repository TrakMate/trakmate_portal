import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'src/utils/app_router.dart';

// // All URLs that MainPage understands.
// const List<String> _mainPaths = [
//   '/',
//   '/home',
//   '/engineering',
//   '/manufacturing',
//   '/products',
//   '/products/trackers',
//   '/products/diagnostics',
//   '/products/gateways',
//   '/products/clusters',
//   '/products/adas',
//   '/solutions-hub',
//   '/news-blogs',
//   '/about',
//   '/about/team',
//   '/about/infrastructure',
//   '/about/careers',
//   '/about/news-blogs',
// ];

// // Same key for every route, so Flutter reuses ONE MainPage state
// // instead of rebuilding the whole page on each navigation.
// const ValueKey<String> _mainPageKey = ValueKey('main-page');

// final GoRouter _router = GoRouter(
//   initialLocation: '/home',
//   routes: [
//     for (final path in _mainPaths)
//       GoRoute(
//         path: path,
//         pageBuilder:
//             (context, state) => NoTransitionPage(
//               key: _mainPageKey,
//               child: MainPage(path: state.uri.path),
//             ),
//       ),
//   ],
// );

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
