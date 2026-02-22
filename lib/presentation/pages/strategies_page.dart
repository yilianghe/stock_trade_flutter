import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/strategy_entity.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/circle_icon_button.dart';
import '../state/providers.dart';

/// Strategies 策略管理页面
/// 对应设计稿的 StrategiesView，展示：
/// 1. 标题 + 添加按钮
/// 2. 策略卡片列表（名称、描述、规则标签、状态、最后运行时间）— 来自 GET /strategies
class StrategiesPage extends ConsumerWidget {
  const StrategiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strategiesAsync = ref.watch(strategyListProvider);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // 标题栏
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Strategies', style: AppTextStyles.heading),
                CircleIconButton(
                  icon: Icons.add_rounded,
                  backgroundColor: AppColors.primaryBlue,
                  iconColor: Colors.white,
                  hasBorder: false,
                  shadow: true,
                  onTap: () {
                    // TODO: 打开创建策略页面
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 策略列表
          Expanded(
            child: strategiesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('加载失败', style: AppTextStyles.bodySecondary),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(strategyListProvider),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
              data: (strategies) {
                if (strategies.isEmpty) {
                  return Center(
                    child: Text('暂无策略', style: AppTextStyles.bodySecondary),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(strategyListProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                    itemCount: strategies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _StrategyCard(strategy: strategies[index]),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 策略卡片
class _StrategyCard extends StatelessWidget {
  const _StrategyCard({required this.strategy});

  final StrategyEntity strategy;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标 + 状态指示
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  size: 20,
                  color: AppColors.primaryBlue,
                ),
              ),
              Row(
                children: [
                  _PulsingDot(active: strategy.active),
                  const SizedBox(width: 6),
                  Text(
                    strategy.active ? 'ACTIVE' : 'PAUSED',
                    style: AppTextStyles.micro.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(strategy.name, style: AppTextStyles.titleMedium),
          const SizedBox(height: 4),
          Text(
            strategy.description,
            style: AppTextStyles.bodySecondary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          // 规则标签
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: strategy.rules.map((rule) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.show_chart_rounded,
                      size: 10,
                      color: AppColors.primaryBlue,
                    ),
                    const SizedBox(width: 4),
                    Text(rule, style: AppTextStyles.monoSmall),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // 底部分隔线 + 最后运行时间 + Configure 按钮
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 10,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(strategy.lastRun, style: AppTextStyles.labelSmall),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: 打开策略配置
                  },
                  child: Text(
                    'CONFIGURE',
                    style: AppTextStyles.micro.copyWith(
                      color: AppColors.primaryBlue,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 呼吸动画圆点（Active 策略显示绿色脉冲）
class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.active});

  final bool active;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.active) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      return Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFD1D5DB),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.priceUp.withValues(
              alpha: 0.5 + _controller.value * 0.5,
            ),
          ),
        );
      },
    );
  }
}
