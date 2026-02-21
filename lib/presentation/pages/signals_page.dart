import 'package:flutter/material.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/circle_icon_button.dart';
import 'signal_detail_page.dart';

/// Signals 信号列表页面
/// 对应设计稿的 SignalsView，展示：
/// 1. 标题
/// 2. 搜索栏 + 筛选按钮
/// 3. 信号卡片列表（可点击进入详情）
class SignalsPage extends StatefulWidget {
  const SignalsPage({super.key});

  @override
  State<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // TODO: 替换为真实 API 数据
  final List<SignalItemData> _allSignals = [
    SignalItemData(
      id: 'sig-1',
      symbol: '600519.SH',
      name: 'Kweichow Moutai',
      price: 1720.50,
      change: 1.25,
      timestamp: '2024-05-20',
      status: 'triggered',
      rules: [
        RuleData(
          name: 'MA5 > MA20',
          description: 'Short term trend above medium term',
          satisfied: true,
          value: '1715.2',
          threshold: '1710.8',
        ),
        RuleData(
          name: 'Volume Surge',
          description: 'Volume exceeds 20-day average by 50%',
          satisfied: true,
          value: '1.8x',
          threshold: '> 1.5x',
        ),
        RuleData(
          name: 'MACD Golden',
          description: 'MACD line crosses above signal line',
          satisfied: true,
          value: '0.45',
          threshold: '> 0',
        ),
      ],
    ),
    SignalItemData(
      id: 'sig-2',
      symbol: '000858.SZ',
      name: 'Wuliangye',
      price: 155.30,
      change: -0.45,
      timestamp: '2024-05-20',
      status: 'pending',
      rules: [
        RuleData(
          name: 'MA5 > MA20',
          description: 'Short term trend above medium term',
          satisfied: true,
          value: '156.1',
          threshold: '154.2',
        ),
        RuleData(
          name: 'Volume Surge',
          description: 'Volume exceeds 20-day average by 50%',
          satisfied: false,
          value: '0.9x',
          threshold: '> 1.5x',
        ),
        RuleData(
          name: 'MACD Golden',
          description: 'MACD line crosses above signal line',
          satisfied: true,
          value: '0.12',
          threshold: '> 0',
        ),
      ],
    ),
  ];

  List<SignalItemData> get _filteredSignals {
    if (_searchQuery.isEmpty) return _allSignals;
    final q = _searchQuery.toLowerCase();
    return _allSignals
        .where((s) =>
            s.symbol.toLowerCase().contains(q) ||
            s.name.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题和搜索栏
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Signals', style: AppTextStyles.heading),
                const SizedBox(height: 16),
                _buildSearchBar(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 信号列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
              itemCount: _filteredSignals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SignalCard(
                    signal: _filteredSignals[index],
                    onTap: () => _openDetail(_filteredSignals[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 搜索栏 + 筛选按钮
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              style: AppTextStyles.bodySecondary.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search symbol...',
                hintStyle: AppTextStyles.bodySecondary,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleIconButton(
          icon: Icons.tune_rounded,
          onTap: () {},
        ),
      ],
    );
  }

  /// 打开信号详情页面
  void _openDetail(SignalItemData signal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SignalDetailPage(signal: signal),
      ),
    );
  }
}

/// 信号卡片
class _SignalCard extends StatelessWidget {
  const _SignalCard({
    required this.signal,
    required this.onTap,
  });

  final SignalItemData signal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isUp = signal.change >= 0;
    final badgeVariant = signal.status == 'triggered'
        ? BadgeVariant.success
        : signal.status == 'failed'
            ? BadgeVariant.danger
            : BadgeVariant.warning;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          children: [
            // 第一行：代码 + Badge + 时间
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(signal.symbol, style: AppTextStyles.stockSymbol),
                    const SizedBox(width: 8),
                    AppBadge(text: signal.status, variant: badgeVariant),
                  ],
                ),
                Text(signal.timestamp, style: AppTextStyles.labelSmall),
              ],
            ),
            const SizedBox(height: 12),
            // 第二行：名称 + 规则满足点 | 价格 + 涨跌幅
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(signal.name, style: AppTextStyles.bodySecondary),
                    const SizedBox(height: 8),
                    // 规则满足指示点
                    Row(
                      children: signal.rules.take(3).map((r) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: r.satisfied
                                ? AppColors.priceUp
                                : const Color(0xFFE5E7EB),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '¥${signal.price.toStringAsFixed(2)}',
                      style: AppTextStyles.priceLarge,
                    ),
                    Text(
                      '${isUp ? '+' : ''}${signal.change}%',
                      style: AppTextStyles.bodySecondary.copyWith(
                        color: isUp ? AppColors.priceUp : AppColors.priceDown,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 信号数据模型（同时给 SignalDetailPage 用）
class SignalItemData {
  final String id;
  final String symbol;
  final String name;
  final double price;
  final double change;
  final String timestamp;
  final String status;
  final List<RuleData> rules;

  SignalItemData({
    required this.id,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.timestamp,
    required this.status,
    required this.rules,
  });
}

/// 规则数据模型
class RuleData {
  final String name;
  final String description;
  final bool satisfied;
  final String value;
  final String threshold;

  RuleData({
    required this.name,
    required this.description,
    required this.satisfied,
    required this.value,
    required this.threshold,
  });
}
