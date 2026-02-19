import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/widgets.dart';
import '../routes/app_router.dart';
import '../state/watchlist_state.dart';

/// 监听列表页
/// 核心入口，展示所有监听股票的状态概览
class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('监听列表'),
      ),
      body: Column(
        children: [
          // 列表内容
          Expanded(
            child: watchlist.when(
              data: (data) {
                if (data.items.isEmpty) {
                  return const EmptyState(
                    message: '暂无监听股票',
                    action: Text('点击下方按钮添加'),
                  );
                }
                return _WatchlistListView(items: data.items);
              },
              loading: () => const LoadingState(message: '加载中...'),
              error: (err, _) => ErrorState(
                message: '加载失败: $err',
                onRetry: () => ref.invalidate(watchlistProvider),
              ),
            ),
          ),
          // 合规提示
          const DisclaimerFooter(),
        ],
      ),
      // 唯一主操作按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(AppRouter.addWatchlist),
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        elevation: 0,
        icon: const Icon(Icons.add, size: 20),
        label: const Text('添加监听'),
      ),
    );
  }
}

/// 监听列表 ListView
class _WatchlistListView extends StatelessWidget {
  const _WatchlistListView({required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _WatchlistItemCard(item: item),
        );
      },
    );
  }
}

/// 监听项卡片
class _WatchlistItemCard extends StatelessWidget {
  const _WatchlistItemCard({required this.item});

  final dynamic item;

  String get _symbol => item.symbol?.toString() ?? '';
  String get _stockName => item.stockName?.toString() ?? '';
  String get _signalStatus => item.signalStatus?.toString() ?? '';
  String? get _updatedAt => item.updatedAt?.toString();
  String? get _explanation => item.explanation?.toString();

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      onTap: () => Navigator.of(context).pushNamed(
        AppRouter.stockDetail,
        arguments: _symbol,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,        children: [
          // Primary: 股票代码
          Text(_symbol, style: AppTextStyles.stockSymbol),
          // Secondary: 股票名称
          Text(_stockName, style: AppTextStyles.stockName),
          const SizedBox(height: 12),
          // 分隔线
          const Divider(height: 1),
          const SizedBox(height: 12),
          // 状态和时间
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 状态指示器
              StatusIndicator(
                status: StatusIndicator.parseStatus(_signalStatus),
              ),
              // Tertiary: 更新时间
              if (_updatedAt != null)
                Text(
                  _updatedAt!,
                  style: AppTextStyles.caption,
                ),
            ],
          ),
          // Tertiary: 说明摘要（如果有）
          if (_explanation != null && _explanation!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _explanation!,
              style: AppTextStyles.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
