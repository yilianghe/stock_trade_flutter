import 'package:flutter/material.dart';

/// 应用颜色系统
/// 遵循克制、理性的设计原则
/// 主色仅1种，状态色仅用于错误或不可用状态
class AppColors {
  AppColors._();

  // ========== 背景色 ==========
  /// 纯白背景
  static const Color background = Color(0xFFFFFFFF);

  /// 浅灰背景（用于区分区域）
  static const Color backgroundSecondary = Color(0xFFF5F5F5);

  // ========== 文字颜色 ==========
  /// Primary 文字 - 近黑（高对比、加粗）
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// Secondary 文字 - 中灰（中等对比）
  static const Color textSecondary = Color(0xFF666666);

  /// Tertiary 文字 - 浅灰（低对比、辅助信息）
  static const Color textTertiary = Color(0xFF999999);

  // ========== 分隔线/边框 ==========
  static const Color divider = Color(0xFFE5E5E5);

  // ========== 状态色 ==========
  /// 仅用于错误或不可用状态
  static const Color error = Color(0xFFD32F2F);

  /// 状态指示器 - 条件满足（中性灰）
  static const Color statusMet = Color(0xFF666666);

  /// 状态指示器 - 条件未满足（中性灰）
  static const Color statusNotMet = Color(0xFF999999);

  /// 状态指示器 - 部分满足（中性灰）
  static const Color statusPartial = Color(0xFF888888);

  /// 状态指示器 - 错误/不可用
  static const Color statusError = Color(0xFFD32F2F);
}
