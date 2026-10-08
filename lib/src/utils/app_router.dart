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

import 'package:go_router/go_router.dart';

import 'package:trakmate_portal/src/ui/pages/main_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      // ============================================================
      // HOME
      // ============================================================
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          return const MainPage(initialIndex: 0, path: '/');
        },
      ),

      // Keep /home working as well.
      GoRoute(
        path: '/home',
        name: 'homeAlias',
        builder: (context, state) {
          return const MainPage(initialIndex: 0, path: '/home');
        },
      ),

      // ============================================================
      // ENGINEERING
      // ============================================================
      GoRoute(
        path: '/engineering',
        name: 'engineering',
        builder: (context, state) {
          return const MainPage(initialIndex: 1, path: '/engineering');
        },
      ),

      // ============================================================
      // MANUFACTURING
      // ============================================================
      GoRoute(
        path: '/manufacturing',
        name: 'manufacturing',
        builder: (context, state) {
          return const MainPage(initialIndex: 2, path: '/manufacturing');
        },
      ),

      // ============================================================
      // PRODUCTS
      // ============================================================
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products');
        },
      ),

      GoRoute(
        path: '/products/trackers',
        name: 'trackers',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products/trackers');
        },
      ),

      GoRoute(
        path: '/products/diagnostics',
        name: 'diagnostics',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products/diagnostics');
        },
      ),

      GoRoute(
        path: '/products/gateways',
        name: 'gateways',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products/gateways');
        },
      ),

      GoRoute(
        path: '/products/clusters',
        name: 'clusters',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products/clusters');
        },
      ),

      GoRoute(
        path: '/products/adas',
        name: 'adas',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/products/adas');
        },
      ),

      // ============================================================
      // SOLUTIONS HUB
      // ============================================================
      GoRoute(
        path: '/solutions-hub',
        name: 'solutionsHub',
        builder: (context, state) {
          return const MainPage(initialIndex: 3, path: '/solutions-hub');
        },
      ),

      // ============================================================
      // NEWS & BLOGS
      // ============================================================
      GoRoute(
        path: '/news-blogs',
        name: 'newsBlogs',
        builder: (context, state) {
          return const MainPage(initialIndex: 4, path: '/news-blogs');
        },
      ),

      // ============================================================
      // ABOUT
      // ============================================================
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) {
          return const MainPage(initialIndex: 5, path: '/about');
        },
      ),

      GoRoute(
        path: '/about/team',
        name: 'aboutTeam',
        builder: (context, state) {
          return const MainPage(initialIndex: 5, path: '/about/team');
        },
      ),

      GoRoute(
        path: '/about/infrastructure',
        name: 'aboutInfrastructure',
        builder: (context, state) {
          return const MainPage(initialIndex: 5, path: '/about/infrastructure');
        },
      ),

      GoRoute(
        path: '/about/careers',
        name: 'aboutCareers',
        builder: (context, state) {
          return const MainPage(initialIndex: 5, path: '/about/careers');
        },
      ),

      GoRoute(
        path: '/about/news-blogs',
        name: 'aboutNewsBlogs',
        builder: (context, state) {
          return const MainPage(initialIndex: 5, path: '/about/news-blogs');
        },
      ),
    ],
  );
}
