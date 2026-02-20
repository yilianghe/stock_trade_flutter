import 'package:flutter/material.dart';
import '../design_system/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

/// 合规提示组件
/// 所有页面底部必须展示
class DisclaimerFooter extends StatelessWidget {
  const DisclaimerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1),
          SizedBox(height: 12),
          Text(
            AppConstants.disclaimer,
            style: AppTextStyles.captionSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
