import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/circle_icon_button.dart';

/// Market（仪表盘）页面
/// 对应设计稿的 DashboardView，展示：
/// 1. 顶部标题栏（Market + 通知/用户按钮）
/// 2. 三张摘要卡片（Signals / Health / Mode）
/// 3. SSE 指数面积图
/// 4. 最近信号列表
class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSummaryCards(),
          const SizedBox(height: 24),
          _buildIndexChart(),
          const SizedBox(height: 24),
          _buildRecentSignals(context),
        ],
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

  /// 三张横向滚动摘要卡片：Signals / Health / Mode
  Widget _buildSummaryCards() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _SummaryCard(
            label: 'SIGNALS',
            value: '12',
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, size: 12, color: AppColors.priceUp),
                const SizedBox(width: 4),
                Text(
                  '+3',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.priceUp),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _SummaryCard(
            label: 'HEALTH',
            value: '98%',
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user_outlined,
                    size: 12, color: AppColors.primaryBlue),
                const SizedBox(width: 4),
                Text(
                  'Verified',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.primaryBlue),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _SummaryCard(
            label: 'MODE',
            value: 'EOD',
            indicator: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time_rounded,
                    size: 12, color: AppColors.warning),
                const SizedBox(width: 4),
                Text(
                  'Waiting',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.warning),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// SSE 指数面积图卡片
  Widget _buildIndexChart() {
    final data = [
      const FlSpot(0, 3100),
      const FlSpot(1, 3150),
      const FlSpot(2, 3120),
      const FlSpot(3, 3180),
      const FlSpot(4, 3200),
    ];
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SSE Composite', style: AppTextStyles.titleSmall),
              const AppBadge(text: 'Bullish', variant: BadgeVariant.success),
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
                  horizontalInterval: 50,
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
                minY: 3050,
                maxY: 3250,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Colors.white,
                    tooltipBorder: const BorderSide(color: AppColors.border),
                    tooltipRoundedRadius: 12,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        final idx = spot.x.toInt();
                        return LineTooltipItem(
                          '${labels[idx]}\n',
                          AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'value : ${spot.y.toInt()}',
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
                    spots: data,
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

  /// 最近信号列表区域
  Widget _buildRecentSignals(BuildContext context) {
    // TODO: 替换为真实 API 数据
    final mockSignals = [
      _SignalData(
        symbol: '600519.SH',
        name: 'Kweichow Moutai',
        price: 1720.50,
        change: 1.25,
        status: 'triggered',
      ),
      _SignalData(
        symbol: '000858.SZ',
        name: 'Wuliangye',
        price: 155.30,
        change: -0.45,
        status: 'pending',
      ),
    ];

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
        ...mockSignals.map((sig) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _RecentSignalItem(signal: sig),
            )),
      ],
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

/// 最近信号列表单项
class _RecentSignalItem extends StatelessWidget {
  const _RecentSignalItem({required this.signal});

  final _SignalData signal;

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

/// 信号数据模型（临时，后续接入 API）
class _SignalData {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final String status;

  _SignalData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.status,
  });
}
