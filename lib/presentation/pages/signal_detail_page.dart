import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_card.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/circle_icon_button.dart';
import 'signals_page.dart';

/// Signal Detail 信号详情页面
/// 对应设计稿的 SignalDetailView，展示：
/// 1. 顶部导航栏（返回按钮 + 标题）
/// 2. 信号摘要卡片（状态、代码、价格、涨跌幅）
/// 3. 规则验证列表（Pass/Fail + 数值对比）
/// 4. 30 天趋势折线图
/// 5. "Add to Watchlist" 操作按钮
class SignalDetailPage extends StatelessWidget {
  const SignalDetailPage({
    super.key,
    required this.signal,
  });

  final SignalItemData signal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部导航栏
            _buildNavBar(context),
            // 滚动内容区
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                children: [
                  const SizedBox(height: 16),
                  _buildSummaryCard(),
                  const SizedBox(height: 24),
                  _buildRuleVerification(),
                  const SizedBox(height: 24),
                  _buildTrendChart(),
                  const SizedBox(height: 24),
                  _buildActionButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 顶部导航栏
  Widget _buildNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          Text('Signal Detail', style: AppTextStyles.titleSmall),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  /// 信号摘要卡片
  Widget _buildSummaryCard() {
    final isUp = signal.change >= 0;
    final badgeVariant = signal.status == 'triggered'
        ? BadgeVariant.success
        : signal.status == 'failed'
            ? BadgeVariant.danger
            : BadgeVariant.warning;

    return AppCard(
      child: Column(
        children: [
          AppBadge(text: signal.status, variant: badgeVariant),
          const SizedBox(height: 8),
          Text(
            signal.symbol,
            style: AppTextStyles.heading.copyWith(fontSize: 28),
          ),
          Text(signal.name, style: AppTextStyles.bodySecondary),
          const SizedBox(height: 24),
          // 价格和涨跌幅
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('PRICE', style: AppTextStyles.labelUppercase),
                  const SizedBox(height: 4),
                  Text(
                    '¥${signal.price.toStringAsFixed(2)}',
                    style: AppTextStyles.priceXL,
                  ),
                ],
              ),
              Container(width: 1, height: 32, color: AppColors.border),
              Column(
                children: [
                  Text('CHANGE', style: AppTextStyles.labelUppercase),
                  const SizedBox(height: 4),
                  Text(
                    '${isUp ? '+' : ''}${signal.change}%',
                    style: AppTextStyles.priceXL.copyWith(
                      color: isUp ? AppColors.priceUp : AppColors.priceDown,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 规则验证列表
  Widget _buildRuleVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text('Rule Verification', style: AppTextStyles.titleSmall),
        ),
        const SizedBox(height: 12),
        ...signal.rules.map((rule) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _RuleCard(rule: rule),
            )),
      ],
    );
  }

  /// 30D 趋势图
  Widget _buildTrendChart() {
    // TODO: 替换为真实 API 数据
    final trendData = [
      const FlSpot(1, 1680),
      const FlSpot(5, 1695),
      const FlSpot(10, 1670),
      const FlSpot(15, 1710),
      const FlSpot(20, 1705),
      const FlSpot(25, 1720),
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('30D Trend', style: AppTextStyles.titleSmall),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border,
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                titlesData: const FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minY: 1650,
                maxY: 1740,
                lineBarsData: [
                  LineChartBarData(
                    spots: trendData,
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 3,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// "Add to Watchlist" 按钮
  Widget _buildActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 调用添加 watchlist API
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to Watchlist')),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Add to Watchlist',
            style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// 规则验证卡片
class _RuleCard extends StatelessWidget {
  const _RuleCard({required this.rule});

  final RuleData rule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pass/Fail 图标
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              rule.satisfied
                  ? Icons.check_circle_rounded
                  : Icons.error_rounded,
              size: 18,
              color: rule.satisfied ? AppColors.priceUp : AppColors.priceDown,
            ),
          ),
          const SizedBox(width: 12),
          // 规则详情
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 规则名 + Pass/Fail 标签
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(rule.name, style: AppTextStyles.titleSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: rule.satisfied
                            ? AppColors.successBg
                            : AppColors.errorBg,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        rule.satisfied ? 'PASS' : 'FAIL',
                        style: AppTextStyles.micro.copyWith(
                          color: rule.satisfied
                              ? AppColors.successText
                              : AppColors.errorText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(rule.description, style: AppTextStyles.stockName),
                const SizedBox(height: 12),
                // Value / Target 数值框
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VALUE', style: AppTextStyles.micro.copyWith(
                              color: AppColors.textSecondary,
                            )),
                            const SizedBox(height: 2),
                            Text(rule.value, style: AppTextStyles.monoData),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TARGET', style: AppTextStyles.micro.copyWith(
                              color: AppColors.textSecondary,
                            )),
                            const SizedBox(height: 2),
                            Text(rule.threshold, style: AppTextStyles.monoData),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
