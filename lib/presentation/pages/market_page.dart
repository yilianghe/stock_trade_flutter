import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/market_index_entity.dart';
import '../../domain/entities/market_overview_entity.dart';
import '../../domain/entities/signal_list_entity.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/circle_icon_button.dart';
import '../state/providers.dart';

/// Market（仪表盘）页面
/// 对应设计稿的 DashboardView，展示：
/// 1. 顶部标题栏（Market + 通知/用户按钮）
/// 2. 三张摘要卡片（Signals / Health / Mode）— 来自 /market/overview
/// 3. SSE 指数面积图 — 来自 /market/index
/// 4. 最近信号列表 — 来自 /signals
class MarketPage extends ConsumerWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () async {
          // 下拉刷新时同时刷新三个数据源
          ref.invalidate(marketOverviewProvider);
          ref.invalidate(marketIndexProvider);
          ref.invalidate(signalListProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _SummaryCardsSection(),
            const SizedBox(height: 24),
            _IndexChartSection(),
            const SizedBox(height: 24),
            _RecentSignalsSection(),
          ],
        ),
      ),
    );
  }

  /// 顶部标题栏：Market 标题 + 通知铃铛 + 用户头像
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Market', style: AppTextStyles.heading),
            const SizedBox(height: 2),
            Text(
              'A-Share EOD Analysis',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
        Row(
          children: [
            CircleIconButton(
              icon: Icons.notifications_outlined,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            CircleIconButton(
              icon: Icons.person_rounded,
              backgroundColor: AppColors.primaryBlue,
              iconColor: Colors.white,
              hasBorder: false,
              shadow: true,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────
// 摘要卡片区域（三张卡片，数据来自 /market/overview）
// ────────────────────────────────────────────────

class _SummaryCardsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(marketOverviewProvider);

    return overviewAsync.when(
      loading: () => const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('加载失败', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(marketOverviewProvider),
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
      data: (overview) => _buildCards(overview),
    );
  }

  Widget _buildCards(MarketOverviewEntity overview) {
    // 信号变化指示器
    final signalsChangeText = overview.signalsChange >= 0
        ? '+${overview.signalsChange}'
        : '${overview.signalsChange}';
    final signalsChangeColor =
        overview.signalsChange >= 0 ? AppColors.priceUp : AppColors.priceDown;
    final signalsChangeIcon =
        overview.signalsChange >= 0 ? Icons.trending_up : Icons.trending_down;

    // 健康度指示器
    final healthColor =
        overview.healthVerified ? AppColors.primaryBlue : AppColors.warning;
    final healthText = overview.healthVerified ? 'Verified' : 'Unverified';
    final healthIcon = overview.healthVerified
        ? Icons.verified_user_outlined
        : Icons.warning_amber_rounded;

    // 模式状态指示器
    final modeStatusColor = switch (overview.modeStatus) {
      'running' => AppColors.priceUp,
      'completed' => AppColors.primaryBlue,
      _ => AppColors.warning,
    };
    final modeStatusText = switch (overview.modeStatus) {
      'running' => 'Running',
      'completed' => 'Completed',
      _ => 'Waiting',
    };
    final modeStatusIcon = switch (overview.modeStatus) {
      'running' => Icons.play_circle_outline,
      'completed' => Icons.check_circle_outline,
      _ => Icons.access_time_rounded,
    };

    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _SummaryCard(
            label: 'SIGNALS',
            value: '${overview.signalsCount}',
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(signalsChangeIcon, size: 12, color: signalsChangeColor),
                const SizedBox(width: 4),
                Text(
                  signalsChangeText,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: signalsChangeColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _SummaryCard(
            label: 'HEALTH',
            value: '${overview.healthPercent}%',
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(healthIcon, size: 12, color: healthColor),
                const SizedBox(width: 4),
                Text(
                  healthText,
                  style:
                      AppTextStyles.labelSmall.copyWith(color: healthColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _SummaryCard(
            label: 'MODE',
            value: overview.mode,
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(modeStatusIcon, size: 12, color: modeStatusColor),
                const SizedBox(width: 4),
                Text(
                  modeStatusText,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: modeStatusColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 摘要卡片（Signals / Health / Mode）
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.indicator,
  });

  final String label;
  final String value;
  final Widget indicator;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: SizedBox(
        width: 128,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.labelUppercase),
            Text(value, style: AppTextStyles.displayNumber),
            indicator,
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────
// SSE 指数面积图（数据来自 /market/index）
// ────────────────────────────────────────────────

class _IndexChartSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexAsync = ref.watch(marketIndexProvider);

    return indexAsync.when(
      loading: () => const AppCard(
        child: SizedBox(
          height: 240,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => AppCard(
        child: SizedBox(
          height: 240,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('图表加载失败', style: AppTextStyles.bodySecondary),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.invalidate(marketIndexProvider),
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (indexData) => _buildChart(indexData),
    );
  }

  Widget _buildChart(MarketIndexEntity indexData) {
    if (indexData.dataPoints.isEmpty) {
      return AppCard(
        child: SizedBox(
          height: 240,
          child: Center(
            child: Text('暂无数据', style: AppTextStyles.bodySecondary),
          ),
        ),
      );
    }

    // 把 API 数据转成图表数据
    final spots = indexData.dataPoints.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value);
    }).toList();

    final labels = indexData.dataPoints.map((p) => p.label).toList();

    // 计算 Y 轴范围（自动适配）
    final values = indexData.dataPoints.map((p) => p.value);
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxVal - minVal) * 0.2;
    final minY = minVal - padding;
    final maxY = maxVal + padding;

    // 趋势 Badge
    final trendVariant = switch (indexData.trend) {
      'bullish' => BadgeVariant.success,
      'bearish' => BadgeVariant.danger,
      _ => BadgeVariant.warning,
    };
    final trendText = switch (indexData.trend) {
      'bullish' => 'Bullish',
      'bearish' => 'Bearish',
      _ => 'Neutral',
    };

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(indexData.indexName, style: AppTextStyles.titleSmall),
              AppBadge(text: trendText, variant: trendVariant),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (maxY - minY) / 4,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[idx],
                              style: AppTextStyles.labelSmall,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      reservedSize: 28,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: minY,
                maxY: maxY,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Colors.white,
                    tooltipBorder: const BorderSide(color: AppColors.border),
                    tooltipRoundedRadius: 12,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final idx = spot.x.toInt();
                        final label =
                            idx < labels.length ? labels[idx] : '';
                        return LineTooltipItem(
                          '$label\n',
                          AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'value : ${spot.y.toStringAsFixed(1)}',
                              style: AppTextStyles.monoData.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, _, __, ___) =>
                          FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.primaryBlue,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primaryBlue.withValues(alpha: 0.1),
                          AppColors.primaryBlue.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────
// 最近信号列表（数据来自 /signals，取前 5 条）
// ────────────────────────────────────────────────

class _RecentSignalsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取最新信号（不带筛选条件）
    final signalsAsync = ref.watch(
      signalListProvider((keyword: null, status: null)),
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Signals', style: AppTextStyles.titleSmall),
            GestureDetector(
              onTap: () {
                // 跳转到 Signals Tab（通过 MainShell 的状态管理）
              },
              child: Text(
                'View All',
                style: AppTextStyles.bodySecondary.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        signalsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('信号加载失败', style: AppTextStyles.bodySecondary),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => ref.invalidate(
                      signalListProvider((keyword: null, status: null)),
                    ),
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
          ),
          data: (signalList) {
            if (signalList.items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child:
                      Text('暂无信号数据', style: AppTextStyles.bodySecondary),
                ),
              );
            }
            // 只显示前 5 条最新信号
            final recentItems = signalList.items.take(5).toList();
            return Column(
              children: recentItems
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _RecentSignalItem(signal: item),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

/// 最近信号列表单项
class _RecentSignalItem extends StatelessWidget {
  const _RecentSignalItem({required this.signal});

  final SignalListItemEntity signal;

  @override
  Widget build(BuildContext context) {
    final isTriggered = signal.status == 'triggered';
    final isUp = signal.change >= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          // 左侧状态图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTriggered
                  ? AppColors.successBg
                  : const Color(0xFFF3F4F6),
            ),
            child: Icon(
              isTriggered ? Icons.flash_on_rounded : Icons.access_time_rounded,
              size: 18,
              color: isTriggered
                  ? AppColors.successText
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          // 股票代码和名称
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(signal.symbol, style: AppTextStyles.stockSymbol),
                Text(signal.name, style: AppTextStyles.stockName),
              ],
            ),
          ),
          // 右侧价格和涨跌幅
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '¥${signal.price.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
              Text(
                '${isUp ? '+' : ''}${signal.change}%',
                style: AppTextStyles.labelSmall.copyWith(
                  color: isUp ? AppColors.priceUp : AppColors.priceDown,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
