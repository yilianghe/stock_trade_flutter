import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../view_models/stock_search_notifier.dart';

class StockSearchPage extends ConsumerStatefulWidget {
  const StockSearchPage({super.key});

  @override
  ConsumerState<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends ConsumerState<StockSearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(stockSearchProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('股票搜索')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(AppConstants.disclaimer, style: AppTextStyles.caption),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: '关键词',
                      hintText: '输入名称或代码',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    ref.read(stockSearchProvider.notifier).search(_controller.text.trim());
                  },
                  child: const Text('搜索'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: result.when(
              data: (items) => ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text('${item.symbol} ${item.name}'),
                    subtitle: Text(item.industry),
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
