// ============================================================================
// File: home_page.dart
// Created Date: 16-Sep-2026
// Title: Home Page
// Description:
//   Entry point for the portfolio home section. Handles responsive
//   navigation between mobile, tablet, desktop, and Ultra HD home views.
//   Each view owns its own navbar.
//
// Class:
//   HomePage
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:ashwanth_portfolio/core/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'desktop/desktop_home_view.dart';
import 'mobile/mobile_home_view.dart';
import 'tablet/tablet_home_view.dart';
import 'ultra_hd/ultra_hd_home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: MobileHomeView(),
        tablet: TabletHomeView(),
        desktop: DesktopHomeView(),
        ultraHd: UltraHdHomeView(),
      ),
    );
  }
}
