// ============================================================================
// File: app_router.dart
// Created Date: 16-Sep-2026
// Title: AppRouter
// Description:
//   Defines all routes used throughout the application.
//
// Class:
//   AppRouter
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const Scaffold(
            body: Center(child: Text('Ashwanth Portfolio')),
          );
        },
      ),
    ],
  );
}
