import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/widgets.dart';

/// 股票详情页
/// 展示单只股票的完整条件监听结果
class StockDetailPage extends ConsumerStatefulWidget {
  const StockDetailPage({super.key});

  @override
  ConsumerState<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends ConsumerState<StockDetailPage> {
  String? _symbol;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 从路由参数获取股票代码
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      _symbol = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_symbol == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('股票详情')),
        body: const ErrorState(message: '未指定股票代码'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_symbol!),
      ),
      body: const _StockDetailContent(),
    );
  }
}

class _StockDetailContent extends ConsumerWidget {
  const _StockDetailContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 这里需要根据实际的数据获取逻辑调整
    // 暂时使用示例数据结构
    return const _PlaceholderContent();
  }
}

/// 占位内容（待接入实际数据）
class _PlaceholderContent extends StatelessWidget {
  const _PlaceholderContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary: 整体条件状态
          const Center(
            child: Text('条件满足', style: AppTextStyles.titleLarge),
          ),
          const SizedBox(height: 24),

          // 分隔线
          const Divider(height: 1),
          const SizedBox(height: 24),

          // Secondary: 通过的规则
          const Text('通过的规则', style: AppTextStyles.titleSmall),
          const SizedBox(height: 8),
          const _RuleItem(text: 'MA5 上穿 MA10'),
          const SizedBox(height: 4),
          const _RuleItem(text: 'MACD 金叉'),
          const SizedBox(height: 16),

          // Secondary: 未通过的规则
          const Text('未通过的规则', style: AppTextStyles.titleSmall),
          const SizedBox(height: 8),
          const _RuleItem(text: 'RSI 未低于阈值', isPassed: false),
          const SizedBox(height: 24),

          // 分隔线
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Tertiary: 说明
          const Text('说明', style: AppTextStyles.titleSmall),
          const SizedBox(height: 8),
          Text(
            '趋势与动量规则满足，但风险过滤未完全通过',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 32),

          // 底部信息
          const Divider(height: 1),
          const SizedBox(height: 12),
          Text(
            '数据时间：2026-02-14 15:02',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 8),
          const DisclaimerFooter(),
        ],
      ),
    );
  }
}

/// 规则项组件
class _RuleItem extends StatelessWidget {
  const _RuleItem({required this.text, this.isPassed = true});

  final String text;
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 圆点指示
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: isPassed
                  ? const Color(0xFF666666)
                  : const Color(0xFF999999),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          // 规则文字
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}
