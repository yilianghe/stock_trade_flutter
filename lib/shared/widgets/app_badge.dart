import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../design_system/app_text_styles.dart';

/// Badge 变体枚举
enum BadgeVariant { normal, success, warning, danger }

/// Apple 风格状态徽章
/// 对应设计稿中的 Badge 组件（TRIGGERED, PENDING, BULLISH 等）
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.normal,
  });

  final String text;
  final BadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.badge.copyWith(color: _textColor),
      ),
    );
  }

  Color get _backgroundColor {
    switch (variant) {
      case BadgeVariant.success:
        return AppColors.successBg;
      case BadgeVariant.warning:
        return AppColors.warningBg;
      case BadgeVariant.danger:
        return AppColors.errorBg;
      case BadgeVariant.normal:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get _textColor {
    switch (variant) {
      case BadgeVariant.success:
        return AppColors.successText;
      case BadgeVariant.warning:
        return AppColors.warningText;
      case BadgeVariant.danger:
        return AppColors.errorText;
      case BadgeVariant.normal:
        return const Color(0xFF4B5563);
    }
  }
}
