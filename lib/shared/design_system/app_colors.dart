import 'package:flutter/material.dart';

/// Apple 风格应用颜色系统
/// 参考 a-signal-pro 设计稿的配色方案
class AppColors {
  AppColors._();

  // ========== 背景色 ==========
  /// 主背景色 - Apple 风格浅灰
  static const Color background = Color(0xFFF5F5F7);

  /// 卡片背景色 - 纯白
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ========== 品牌色 ==========
  /// Apple 蓝 - 主色调
  static const Color primaryBlue = Color(0xFF0071E3);

  // ========== 文字颜色 ==========
  /// 主文字 - 深色
  static const Color textPrimary = Color(0xFF1D1D1F);

  /// 次要文字 - 中灰
  static const Color textSecondary = Color(0xFF86868B);

  // ========== 状态色 ==========
  /// 成功/看涨 - 翡翠绿
  static const Color success = Color(0xFF28CD41);

  /// 成功背景
  static const Color successBg = Color(0xFFECFDF5);

  /// 成功文字
  static const Color successText = Color(0xFF059669);

  /// 警告 - 琥珀色
  static const Color warning = Color(0xFFF59E0B);

  /// 警告背景
  static const Color warningBg = Color(0xFFFFFBEB);

  /// 警告文字
  static const Color warningText = Color(0xFFD97706);

  /// 错误/看跌 - 玫红
  static const Color error = Color(0xFFFF3B30);

  /// 错误背景
  static const Color errorBg = Color(0xFFFFF1F2);

  /// 错误文字
  static const Color errorText = Color(0xFFE11D48);

  // ========== 分隔线/边框 ==========
  /// 边框和分隔线
  static const Color border = Color(0xFFF3F4F6);

  /// 次要区域背景
  static const Color surfaceSecondary = Color(0xFFF9FAFB);

  // ========== 涨跌色 ==========
  /// 涨 - 翡翠绿
  static const Color priceUp = Color(0xFF10B981);

  /// 跌 - 玫红
  static const Color priceDown = Color(0xFFEF4444);

  // ========== 向下兼容（旧页面使用） ==========
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color textTertiary = Color(0xFF999999);
  static const Color divider = Color(0xFFE5E5E5);
  static const Color statusMet = Color(0xFF666666);
  static const Color statusNotMet = Color(0xFF999999);
  static const Color statusPartial = Color(0xFF888888);
  static const Color statusError = Color(0xFFD32F2F);
}
