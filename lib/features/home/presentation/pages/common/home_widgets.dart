// ============================================================================
// File: home_widgets.dart
// Created Date: 16-Sep-2026
// Title: HomeWidgets
// Description:
//   Contains reusable UI components used throughout the portfolio home page.
//   Provides responsive sizing and styling for the hero section, statistics,
//   and other home-specific components.
//
// Class:
//   HomeWidgets
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:ashwanth_portfolio/core/constants/image_assets.dart';
import 'package:ashwanth_portfolio/core/responsive/responsive.dart';
import 'package:ashwanth_portfolio/core/theme/app_colors.dart';
import 'package:ashwanth_portfolio/core/theme/app_spacing.dart';
import 'package:ashwanth_portfolio/core/theme/app_text_styles.dart';
import 'package:ashwanth_portfolio/core/widgets/app_button.dart';
import 'package:ashwanth_portfolio/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class HomeWidgets {
  HomeWidgets._();

  // ==========================================================================
  // Responsive Values
  // ==========================================================================

  static double horizontalPadding(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 20,
      ResponsiveDevice.tablet => 32,
      ResponsiveDevice.desktop => 48,
      ResponsiveDevice.ultraHd => 64,
    };
  }

  static double sectionSpacing(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 48,
      ResponsiveDevice.tablet => 64,
      ResponsiveDevice.desktop => 80,
      ResponsiveDevice.ultraHd => 96,
    };
  }

  static double heroTitleSize(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 42,
      ResponsiveDevice.tablet => 50,
      ResponsiveDevice.desktop => 64,
      ResponsiveDevice.ultraHd => 76,
    };
  }

  static double heroSubtitleSize(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 20,
      ResponsiveDevice.tablet => 24,
      ResponsiveDevice.desktop => 28,
      ResponsiveDevice.ultraHd => 32,
    };
  }

  static double bodySize(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 14,
      ResponsiveDevice.tablet => 15,
      ResponsiveDevice.desktop => 16,
      ResponsiveDevice.ultraHd => 18,
    };
  }

  // ==========================================================================
  // Hero Section
  // ==========================================================================

  static Widget heroContent({required ResponsiveDevice device}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heroEyebrow(),

        const SizedBox(height: AppSpacing.md),

        _heroTitle(device),

        const SizedBox(height: AppSpacing.md),

        Text(
          'Flutter Developer | Immediate Joiner',
          style: AppTextStyles.heading3.copyWith(
            fontSize: heroSubtitleSize(device),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'Building scalable cross-platform applications'
            'for mobile, web and desktop.\nI enjoy solving '
            'complex problems and turning ideas into impactful products. ',
            style: AppTextStyles.body.copyWith(fontSize: bodySize(device)),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        heroActions(device),
      ],
    );
  }

  static Widget _heroEyebrow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'HELLO, I\'M',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primaryLight,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static Widget _heroTitle(ResponsiveDevice device) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Ashwanth\n',
            style: AppTextStyles.heading1.copyWith(
              fontSize: heroTitleSize(device),
              height: 1.05,
            ),
          ),
          TextSpan(
            text: 'V Praveen',
            style: AppTextStyles.heading1.copyWith(
              fontSize: heroTitleSize(device),
              height: 1.05,
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }

  static Widget heroActions(
    ResponsiveDevice device, {
    VoidCallback? onViewWork,
    VoidCallback? onDownloadResume,
  }) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        _HoverScale(
          scale: 1.03,
          child: AppButton(
            label: 'View My Work',
            icon: Icons.arrow_forward_rounded,
            iconPosition: AppButtonIconPosition.right,
            device: device,
            onPressed: onViewWork,
          ),
        ),
        _HoverScale(
          scale: 1.03,
          child: AppButton(
            label: 'Download Resume',
            type: AppButtonType.outlined,
            icon: Icons.download_rounded,
            device: device,
            onPressed: onDownloadResume,
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // Hero Visual (layered: bg glow, body photo, handwritten text)
  // ==========================================================================
  static Widget heroVisual({required ResponsiveDevice device}) {
    final visualSize = switch (device) {
      ResponsiveDevice.mobile => 280.0,
      ResponsiveDevice.tablet => 360.0,
      ResponsiveDevice.desktop => 460.0,
      ResponsiveDevice.ultraHd => 560.0,
    };

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: visualSize,
          height: visualSize,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                ImageAssets.homeBg,
                width: visualSize,
                height: visualSize,
                fit: BoxFit.contain,
              ),
              Image.asset(
                ImageAssets.homeImageBody,
                width: visualSize,
                height: visualSize,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // Statistics
  // ==========================================================================
  static Widget stats({required ResponsiveDevice device}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          numberStatCard(
            value: '2+',
            label: 'Years Experience',
            device: device,
          ),
          const SizedBox(width: AppSpacing.md),
          numberStatCard(value: '5+', label: 'Projects', device: device),
          const SizedBox(width: AppSpacing.md),
          iconStatCard(
            icon: Icons.devices_rounded,
            title: 'Cross-platform',
            subtitle: 'Android · iOS · Web · Desktop',
            device: device,
          ),
          const SizedBox(width: AppSpacing.md),
          iconStatCard(
            icon: Icons.shield_outlined,
            title: 'Problem Solver',
            device: device,
          ),
        ],
      ),
    );
  }

  static Widget numberStatCard({
    required String value,
    required String label,
    required ResponsiveDevice device,
  }) {
    return _HoverScale(
      child: AppCard(
        device: device,
        width: switch (device) {
          ResponsiveDevice.mobile => 150,
          ResponsiveDevice.tablet => 170,
          ResponsiveDevice.desktop => 190,
          ResponsiveDevice.ultraHd => 220,
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.heading2.copyWith(
                fontSize: switch (device) {
                  ResponsiveDevice.mobile => 28,
                  ResponsiveDevice.tablet => 30,
                  ResponsiveDevice.desktop => 32,
                  ResponsiveDevice.ultraHd => 36,
                },
                color: AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontSize: bodySize(device) * 0.85,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget iconStatCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required ResponsiveDevice device,
  }) {
    return _HoverScale(
      child: AppCard(
        device: device,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _technologyIcon(icon),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontSize: bodySize(device),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: bodySize(device) * 0.8,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _technologyIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.20)),
      ),
      child: Icon(icon, color: AppColors.primaryLight, size: 20),
    );
  }
}

// ==========================================================================
// Hover-lift wrapper: subtle scale + glow shadow on mouse hover.
// ==========================================================================

class _HoverScale extends StatefulWidget {
  const _HoverScale({required this.child, this.scale = 1.04});

  final Widget child;
  final double scale;

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
