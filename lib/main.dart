import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'src/ui/pages/main_page.dart';

// All URLs that MainPage understands (matches _indexFromPath in main_page.dart)
const List<String> _mainPaths = [
  '/',
  '/home',
  '/engineering',
  '/manufacturing',
  '/products',
  '/products/trackers',
  '/products/diagnostics',
  '/products/gateways',
  '/products/clusters',
  '/products/adas',
  '/solutions-hub',
  '/news-blogs',
  '/about',
  '/about/team',
  '/about/infrastructure',
  '/about/careers',
  '/about/news-blogs',
];

// Same key for every route, so Flutter reuses ONE MainPage state
// instead of rebuilding the whole page on each navigation.
const ValueKey<String> _mainPageKey = ValueKey('main-page');

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    for (final path in _mainPaths)
      GoRoute(
        path: path,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: _mainPageKey,
              child: MainPage(path: state.uri.path),
            ),
      ),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ADD
  PaintingBinding.instance.imageCache.maximumSizeBytes = 300 * 1024 * 1024;

  // WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy(); // clean URLs: /products instead of /#/products
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
      routerConfig: _router,
    );
  }
}
