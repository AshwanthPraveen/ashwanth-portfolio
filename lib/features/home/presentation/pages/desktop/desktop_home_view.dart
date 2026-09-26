// ============================================================================
// File: desktop_home_view.dart
// Created Date: 16-Sep-2026
// Title: DesktopHomeView
// Description:
//   Defines the desktop-specific layout of the portfolio home page,
//   including its own navbar and staggered entrance animations for the
//   hero and stats sections.
//
// Class:
//   DesktopHomeView
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:ashwanth_portfolio/core/constants/image_assets.dart';
import 'package:ashwanth_portfolio/core/responsive/responsive.dart';
import 'package:ashwanth_portfolio/core/theme/app_colors.dart';
import 'package:ashwanth_portfolio/core/theme/app_spacing.dart';
import 'package:ashwanth_portfolio/core/theme/app_text_styles.dart';
import 'package:ashwanth_portfolio/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../common/home_widgets.dart';

class DesktopHomeView extends StatefulWidget {
  const DesktopHomeView({super.key});

  @override
  State<DesktopHomeView> createState() => _DesktopHomeViewState();
}

class _DesktopHomeViewState extends State<DesktopHomeView>
    with SingleTickerProviderStateMixin {
  static const _navRoutes = [
    '/',
    '/about',
    '/projects',
    '/experience',
    '/skills',
  ];
  static const _navLabels = [
    'Home',
    'About',
    'Projects',
    'Experience',
    'Skills',
  ];

  late final AnimationController _controller;

  late final Animation<double> _heroTextFade;
  late final Animation<Offset> _heroTextSlide;

  late final Animation<double> _heroVisualFade;
  late final Animation<double> _heroVisualScale;

  late final Animation<double> _statsFade;
  late final Animation<Offset> _statsSlide;

  String _currentRoute = '/';
  String? _hoveredRoute;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _heroTextFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _heroTextSlide =
        Tween<Offset>(begin: const Offset(-0.08, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    _heroVisualFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    );
    _heroVisualScale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _statsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );
    _statsSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.45, 1.0, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const device = ResponsiveDevice.desktop;
    final horizontalPadding = HomeWidgets.horizontalPadding(device);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _navbar(device),
          ),

          const SizedBox(height: AppSpacing.sm),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildHeroWithStats(device)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // Navbar
  // ==========================================================================

  Widget _navbar(ResponsiveDevice device) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Image.asset(ImageAssets.logo, height: 50, fit: BoxFit.contain),

          const Spacer(),

          for (final route in _navRoutes) _navItem(route),

          const SizedBox(width: AppSpacing.lg),

          AppButton(
            label: 'Contact Me',
            device: device,
            onPressed: () => setState(() => _currentRoute = '/contact'),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String route) {
    final index = _navRoutes.indexOf(route);
    final label = _navLabels[index];
    final isActive = _currentRoute == route;
    final isHovered = _hoveredRoute == route;
    final highlighted = isActive || isHovered;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveredRoute = route),
        onExit: (_) => setState(() => _hoveredRoute = null),
        child: GestureDetector(
          onTap: () => setState(() => _currentRoute = route),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                style: AppTextStyles.caption.copyWith(
                  color: highlighted
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 2,
                width: highlighted ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // Hero + Stats (stats overlap the bottom edge of the hero row)
  // ==========================================================================

  Widget _buildHeroWithStats(ResponsiveDevice device) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: FadeTransition(
                opacity: _heroTextFade,
                child: SlideTransition(
                  position: _heroTextSlide,
                  child: HomeWidgets.heroContent(device: device),
                ),
              ),
            ),

            // const SizedBox(width: AppSpacing.xl),
            Expanded(
              flex: 5,
              child: Center(
                child: FadeTransition(
                  opacity: _heroVisualFade,
                  child: ScaleTransition(
                    scale: _heroVisualScale,
                    child: HomeWidgets.heroVisual(device: device),
                  ),
                ),
              ),
            ),
          ],
        ),

        Transform.translate(
          offset: const Offset(0, -65),
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxxs),
            child: FadeTransition(
              opacity: _statsFade,
              child: SlideTransition(
                position: _statsSlide,
                child: HomeWidgets.stats(device: device),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
