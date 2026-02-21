import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';

/// 圆形图标按钮
/// 用于顶栏的通知铃铛、用户头像、返回按钮等
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
    this.iconSize = 20,
    this.hasBorder = true,
    this.shadow = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final bool hasBorder;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? AppColors.cardBackground,
          border: hasBorder
              ? Border.all(color: AppColors.border, width: 1)
              : null,
          boxShadow: shadow
              ? [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.textSecondary,
        ),
      ),
    );
  }
}
