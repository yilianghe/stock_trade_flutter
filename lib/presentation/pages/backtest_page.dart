import 'package:flutter/material.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';

/// Backtest 回测页面（占位）
/// 对应设计稿的 BacktestView，目前显示占位信息
class BacktestPage extends StatelessWidget {
  const BacktestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图标
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceSecondary,
                ),
                child: const Icon(
                  Icons.history_rounded,
                  size: 32,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              // 标题
              Text(
                'Backtesting Engine',
                style: AppTextStyles.titleMedium.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              // 说明文字
              Text(
                'The backtesting module is currently being optimized for mobile devices. Check back soon.',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // "Learn More" 按钮
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Learn More',
                  style: AppTextStyles.bodySecondary.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
