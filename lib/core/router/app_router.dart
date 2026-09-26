// ============================================================================
// File: app_router.dart
// Created Date: 16-Sep-2026
// Title: AppRouter
// Description:
//   Defines application routes and navigation configuration.
//
// Class:
//   AppRouter
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [GoRoute(path: '/', builder: (context, state) => const HomePage())],
  );
}
