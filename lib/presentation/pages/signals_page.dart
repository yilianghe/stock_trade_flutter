import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/signal_list_entity.dart';
import '../../shared/design_system/app_colors.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/app_badge.dart';
import '../../shared/widgets/circle_icon_button.dart';
import '../state/providers.dart';
import 'signal_detail_page.dart';

/// Signals 信号列表页面
/// 对应设计稿的 SignalsView，展示：
/// 1. 标题
/// 2. 搜索栏 + 筛选按钮
/// 3. 信号卡片列表（可点击进入详情）— 数据来自 GET /signals
class SignalsPage extends ConsumerStatefulWidget {
  const SignalsPage({super.key});

  @override
  ConsumerState<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends ConsumerState<SignalsPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 根据搜索关键词获取信号列表
    final signalsAsync = ref.watch(
      signalListProvider((keyword: _searchQuery.isEmpty ? null : _searchQuery, status: null)),
    );

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
            child: signalsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('加载失败', style: AppTextStyles.bodySecondary),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(
                        signalListProvider((keyword: _searchQuery.isEmpty ? null : _searchQuery, status: null)),
                      ),
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
              data: (signalList) {
                if (signalList.items.isEmpty) {
                  return Center(
                    child: Text('暂无信号数据', style: AppTextStyles.bodySecondary),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(
                      signalListProvider((keyword: _searchQuery.isEmpty ? null : _searchQuery, status: null)),
                    );
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                    itemCount: signalList.items.length,
                    itemBuilder: (context, index) {
                      final signal = signalList.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SignalCard(
                          signal: signal,
                          onTap: () => _openDetail(signal),
                        ),
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
  void _openDetail(SignalListItemEntity signal) {
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

  final SignalListItemEntity signal;
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
