import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../state/watchlist_state.dart';
import '../../shared/design_system/app_text_styles.dart';

class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('关注列表')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(AppConstants.disclaimer, style: AppTextStyles.caption),
          ),
          Expanded(
            child: watchlist.when(
              data: (data) => ListView.separated(
                itemCount: data.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = data.items[index];
                  return ListTile(
                    title: Text('${item.symbol} ${item.stockName}'),
                    subtitle: Text(item.tags.join(' / ')),
                    trailing: item.updatedAt != null ? Text(item.updatedAt!) : null,
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('加载失败: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
