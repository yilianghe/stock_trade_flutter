import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';
import '../design_system/app_text_styles.dart';

/// 信号状态枚举
enum SignalStatus {
  met, // 条件满足
  notMet, // 条件未满足
  partial, // 部分满足
  error, // 错误/不可用
}

/// 状态指示器组件
/// 用于展示股票条件状态
/// 遵循克制设计原则：使用中性色灰阶
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
    required this.status,
    this.showLabel = true,
  });

  final SignalStatus status;
  final bool showLabel;

  /// 获取状态对应的颜色
  Color get _color {
    switch (status) {
      case SignalStatus.met:
        return AppColors.statusMet;
      case SignalStatus.notMet:
        return AppColors.statusNotMet;
      case SignalStatus.partial:
        return AppColors.statusPartial;
      case SignalStatus.error:
        return AppColors.statusError;
    }
  }

  /// 获取状态对应的文字
  String get _label {
    switch (status) {
      case SignalStatus.met:
        return '条件满足';
      case SignalStatus.notMet:
        return '条件未满足';
      case SignalStatus.partial:
        return '部分满足';
      case SignalStatus.error:
        return '数据异常';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 圆点指示器
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _color,
            shape: BoxShape.circle,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(width: 8),
          Text(
            _label,
            style: AppTextStyles.statusLabel.copyWith(color: _color),
          ),
        ],
      ],
    );
  }

  /// 从后端状态字符串解析
  static SignalStatus parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'condition_met':
      case 'met':
        return SignalStatus.met;
      case 'condition_not_met':
      case 'not_met':
        return SignalStatus.notMet;
      case 'partial':
        return SignalStatus.partial;
      default:
        return SignalStatus.error;
    }
  }
}
