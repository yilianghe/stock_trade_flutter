import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Apple 风格文字样式系统
/// 使用 Inter 字体 + JetBrains Mono 等宽字体
class AppTextStyles {
  AppTextStyles._();

  // ========== 标题样式 ==========
  /// 页面大标题 - 24pt 粗体
  static TextStyle get heading => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  /// 大数字 - 30pt 轻体（Dashboard 摘要卡片用）
  static TextStyle get displayNumber => GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w300,
        color: AppColors.textPrimary,
      );

  /// 中等标题 - 18pt
  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  /// 小标题 - 14pt 半粗
  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // ========== 正文样式 ==========
  /// 标准正文 - 14pt
  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// 次要正文 - 12pt
  static TextStyle get bodySecondary => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // ========== 辅助文字 ==========
  /// 极小标签 - 10pt 粗体大写（摘要卡片标签）
  static TextStyle get labelUppercase => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 1.5,
      );

  /// 小标签 - 10pt
  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  /// 极小文字 - 8pt 粗体大写（Badge、Pass/Fail 标记）
  static TextStyle get micro => GoogleFonts.inter(
        fontSize: 8,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  // ========== 数据展示 ==========
  /// 价格 - 等宽字体 14pt
  static TextStyle get price => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// 大价格 - 等宽字体 18pt
  static TextStyle get priceLarge => GoogleFonts.jetBrainsMono(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// 超大价格 - 等宽字体 20pt
  static TextStyle get priceXL => GoogleFonts.jetBrainsMono(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// 等宽小字 - 10pt（策略规则标签）
  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// 等宽数据 - 12pt
  static TextStyle get monoData => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  // ========== 股票特有 ==========
  /// 股票代码 - 14pt 粗体
  static TextStyle get stockSymbol => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  /// 股票名称 - 10pt 次要色
  static TextStyle get stockName => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // ========== Badge 样式 ==========
  /// Badge 文字 - 10pt 粗体大写
  static TextStyle get badge => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  // ========== 向下兼容（旧页面使用） ==========
  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get captionSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get statusLabel => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        height: 1.3,
      );
}
