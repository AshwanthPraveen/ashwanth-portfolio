// ============================================================================
// File: app_button.dart
// Created Date: 16-Sep-2026
// Title: AppButton
// Description:
//   Provides a reusable and customizable button component used throughout
//   the application. Supports primary, outlined, and text button variants,
//   optional icons, loading states, responsive sizing, and consistent
//   application-wide styling.
//
// Class:
//   AppButton
//
// Author: Ashwanth V Praveen
// ============================================================================

import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppButtonType { primary, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.iconPosition = AppButtonIconPosition.left,
    this.isLoading = false,
    this.isFullWidth = false,
    this.width,
    this.height,
    this.device,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final AppButtonIconPosition iconPosition;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;
  final ResponsiveDevice? device;

  @override
  Widget build(BuildContext context) {
    final currentDevice = device ?? Responsive.device(context);

    final buttonHeight = height ?? _height(currentDevice);
    final horizontalPadding = _horizontalPadding(currentDevice);
    final textStyle = _textStyle(currentDevice);

    final Widget content = isLoading
        ? _loadingIndicator(currentDevice)
        : _buildContent(textStyle);

    final Widget button = switch (type) {
      AppButtonType.primary => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _primaryStyle(
          buttonHeight: buttonHeight,
          horizontalPadding: horizontalPadding,
        ),
        child: content,
      ),
      AppButtonType.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: _outlinedStyle(
          buttonHeight: buttonHeight,
          horizontalPadding: horizontalPadding,
        ),
        child: content,
      ),
      AppButtonType.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: _textButtonStyle(
          buttonHeight: buttonHeight,
          horizontalPadding: horizontalPadding,
        ),
        child: content,
      ),
    };

    if (width != null) {
      return SizedBox(width: width, height: buttonHeight, child: button);
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: buttonHeight,
        child: button,
      );
    }

    return SizedBox(height: buttonHeight, child: button);
  }

  // --------------------------------------------------------------------------
  // Content
  // --------------------------------------------------------------------------

  Widget _buildContent(TextStyle textStyle) {
    if (icon == null) {
      return Text(label, style: textStyle);
    }

    final iconWidget = Icon(icon, size: 18);

    final textWidget = Text(label, style: textStyle);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == AppButtonIconPosition.left
          ? [iconWidget, const SizedBox(width: AppSpacing.xs), textWidget]
          : [textWidget, const SizedBox(width: AppSpacing.xs), iconWidget],
    );
  }

  Widget _loadingIndicator(ResponsiveDevice device) {
    return SizedBox(
      width: _loadingSize(device),
      height: _loadingSize(device),
      child: CircularProgressIndicator(strokeWidth: 2, color: _loadingColor()),
    );
  }

  // --------------------------------------------------------------------------
  // Styles
  // --------------------------------------------------------------------------

  ButtonStyle _primaryStyle({
    required double buttonHeight,
    required double horizontalPadding,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
      disabledForegroundColor: AppColors.textPrimary.withValues(alpha: 0.7),
      elevation: 0,
      minimumSize: Size(0, buttonHeight),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  ButtonStyle _outlinedStyle({
    required double buttonHeight,
    required double horizontalPadding,
  }) {
    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.textPrimary,
      disabledForegroundColor: AppColors.textMuted,
      minimumSize: Size(0, buttonHeight),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      side: const BorderSide(color: AppColors.primary, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  ButtonStyle _textButtonStyle({
    required double buttonHeight,
    required double horizontalPadding,
  }) {
    return TextButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      disabledForegroundColor: AppColors.textMuted,
      minimumSize: Size(0, buttonHeight),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  // --------------------------------------------------------------------------
  // Responsive Values
  // --------------------------------------------------------------------------

  double _height(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 44,
      ResponsiveDevice.tablet => 46,
      ResponsiveDevice.desktop => 48,
      ResponsiveDevice.ultraHd => 52,
    };
  }

  double _horizontalPadding(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 16,
      ResponsiveDevice.tablet => 18,
      ResponsiveDevice.desktop => 22,
      ResponsiveDevice.ultraHd => 26,
    };
  }

  double _loadingSize(ResponsiveDevice device) {
    return switch (device) {
      ResponsiveDevice.mobile => 16,
      ResponsiveDevice.tablet => 17,
      ResponsiveDevice.desktop => 18,
      ResponsiveDevice.ultraHd => 20,
    };
  }

  TextStyle _textStyle(ResponsiveDevice device) {
    final fontSize = switch (device) {
      ResponsiveDevice.mobile => 14.0,
      ResponsiveDevice.tablet => 14.0,
      ResponsiveDevice.desktop => 15.0,
      ResponsiveDevice.ultraHd => 16.0,
    };

    return AppTextStyles.body.copyWith(
      fontSize: fontSize,
      color: type == AppButtonType.primary
          ? AppColors.textPrimary
          : AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    );
  }

  Color _loadingColor() {
    return switch (type) {
      AppButtonType.primary => AppColors.textPrimary,
      AppButtonType.outlined => AppColors.primaryLight,
      AppButtonType.text => AppColors.primaryLight,
    };
  }
}

enum AppButtonIconPosition { left, right }
