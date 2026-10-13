import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:trakmate_portal/src/ui/pages/main_page.dart';
import 'package:trakmate_portal/src/ui/widgets/careers_details.dart';

class AppRouter {
  // Reuse the same MainPage when navigating between sections.
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
      // ABOUT US
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

      // Careers: the full Careers page, with its own URL.
      GoRoute(
        path: '/about_us/careers',
        name: 'aboutUsCareers',
        builder: (context, state) => const CareersPage(),
      ),

      // Legacy careers URL: redirects to the new one
      GoRoute(
        path: '/about/careers',
        name: 'aboutCareers',
        redirect: (context, state) => '/about_us/careers',
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
