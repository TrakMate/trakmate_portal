import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:trakmate_portal/src/ui/pages/main_page.dart';

class AppRouter {
  // path -> index of the section shown in MainPage's IndexedStack
  static const Map<String, int> _pages = {
    '/home': 0,
    '/engineering': 1,
    '/manufacturing': 2,
    '/products': 3,
    '/products/trackers': 3,
    '/products/diagnostics': 3,
    '/products/gateways': 3,
    '/products/clusters': 3,
    '/products/adas': 3,
    '/solutions-hub': 3,
    '/news-blogs': 4,
    '/about': 5,
    '/about/team': 5,
    '/about/infrastructure': 5,
    '/about/careers': 5,
  };

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      // "/" -> "/home"
      // GoRoute(path: '/', redirect: (context, state) => '/home'),
      for (final entry in _pages.entries)
        GoRoute(
          path: entry.key,
          pageBuilder:
              (context, state) => NoTransitionPage<void>(
                // Same key for every route, so MainPage is NOT recreated.
                key: const ValueKey('main-page'),
                child: MainPage(
                  initialIndex: entry.value,
                  path: state.uri.path,
                ),
              ),
        ),
    ],
  );
}
