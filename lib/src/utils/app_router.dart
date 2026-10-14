// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// // import 'package:go_router/go_router.dart';
// import 'package:trakmate_portal/src/ui/pages/main_page.dart';

// class AppRouter {
//   // path -> index of the section shown in MainPage's IndexedStack
//   static const Map<String, int> _pages = {
//     '/home': 0,
//     '/engineering': 1,
//     '/manufacturing': 2,
//     '/products': 3,
//     '/products/trackers': 3,
//     '/products/diagnostics': 3,
//     '/products/gateways': 3,
//     '/products/clusters': 3,
//     '/products/adas': 3,
//     '/solutions-hub': 3,
//     '/news-blogs': 4,
//     '/about': 5,
//     '/about/team': 5,
//     '/about/infrastructure': 5,
//     '/about/careers': 5,
//   };

//   static final GoRouter router = GoRouter(
//     initialLocation: '/home',
//     routes: [
//       // "/" -> "/home"
//       // GoRoute(path: '/', redirect: (context, state) => '/home'),
//       for (final entry in _pages.entries)
//         GoRoute(
//           path: entry.key,
//           pageBuilder:
//               (context, state) => NoTransitionPage<void>(
//                 // Same key for every route, so MainPage is NOT recreated.
//                 key: const ValueKey('main-page'),
//                 child: MainPage(
//                   initialIndex: entry.value,
//                   path: state.uri.path,
//                 ),
//               ),
//         ),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:trakmate_portal/src/ui/pages/main_page.dart';

class AppRouter {
  // Every route shows the SAME MainPage and uses this SAME page key, so
  // go_router keeps the existing MainPage alive and only hands it the new path
  // (MainPage.didUpdateWidget handles it). The hero/header is therefore NOT
  // rebuilt when you switch filter tabs - only the products content changes.
  static const ValueKey<String> _mainPageKey = ValueKey<String>('main-page');

  static Page<void> _mainPage(Widget child) {
    return NoTransitionPage<void>(key: _mainPageKey, child: child);
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      // ============================================================
      // HOME
      // ============================================================
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return _mainPage(const MainPage(initialIndex: 0, path: '/'));
        },
      ),

      // Keep /home working as well.
      GoRoute(
        path: '/home',
        name: 'homeAlias',
        pageBuilder: (context, state) {
          return _mainPage(const MainPage(initialIndex: 0, path: '/home'));
        },
      ),

      // ============================================================
      // ENGINEERING
      // ============================================================
      GoRoute(
        path: '/engineering',
        name: 'engineering',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 1, path: '/engineering'),
          );
        },
      ),

      // ============================================================
      // MANUFACTURING
      // ============================================================
      GoRoute(
        path: '/manufacturing',
        name: 'manufacturing',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 2, path: '/manufacturing'),
          );
        },
      ),

      // ============================================================
      // PRODUCTS
      // ============================================================
      GoRoute(
        path: '/products',
        name: 'products',
        pageBuilder: (context, state) {
          return _mainPage(const MainPage(initialIndex: 3, path: '/products'));
        },
      ),

      GoRoute(
        path: '/products/telematics',
        name: 'telematics',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/products/telematics'),
          );
        },
      ),

      GoRoute(
        path: '/products/diagnostics',
        name: 'diagnostics',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/products/diagnostics'),
          );
        },
      ),

      GoRoute(
        path: '/products/gateways',
        name: 'gateways',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/products/gateways'),
          );
        },
      ),

      GoRoute(
        path: '/products/clusters',
        name: 'clusters',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/products/clusters'),
          );
        },
      ),

      GoRoute(
        path: '/products/adas',
        name: 'adas',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/products/adas'),
          );
        },
      ),

      // ============================================================
      // SOLUTIONS HUB
      // ============================================================
      GoRoute(
        path: '/solutions-hub',
        name: 'solutionsHub',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 3, path: '/solutions-hub'),
          );
        },
      ),

      // ============================================================
      // NEWS & BLOGS
      // ============================================================
      GoRoute(
        path: '/news-blogs',
        name: 'newsBlogs',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 4, path: '/news-blogs'),
          );
        },
      ),

      // ============================================================
      // ABOUT
      // ============================================================
      GoRoute(
        path: '/about',
        name: 'about',
        pageBuilder: (context, state) {
          return _mainPage(const MainPage(initialIndex: 5, path: '/about'));
        },
      ),

      GoRoute(
        path: '/about/team',
        name: 'aboutTeam',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 5, path: '/about/team'),
          );
        },
      ),

      GoRoute(
        path: '/about/infrastructure',
        name: 'aboutInfrastructure',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 5, path: '/about/infrastructure'),
          );
        },
      ),

      GoRoute(
        path: '/about/careers',
        name: 'aboutCareers',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 5, path: '/about/careers'),
          );
        },
      ),

      GoRoute(
        path: '/about/news-blogs',
        name: 'aboutNewsBlogs',
        pageBuilder: (context, state) {
          return _mainPage(
            const MainPage(initialIndex: 5, path: '/about/news-blogs'),
          );
        },
      ),
    ],
  );
}
