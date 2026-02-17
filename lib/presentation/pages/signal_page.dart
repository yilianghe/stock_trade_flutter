import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../view_models/signal_history_notifier.dart';

class SignalPage extends ConsumerStatefulWidget {
  const SignalPage({super.key});

  @override
  ConsumerState<SignalPage> createState() => _SignalPageState();
}

class _SignalPageState extends ConsumerState<SignalPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(signalHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('信号历史')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
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
                      labelText: '股票代码',
                      hintText: '例如 000001.SZ',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    ref.read(signalHistoryProvider.notifier).load(_controller.text.trim());
                  },
                  child: const Text('查询'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: history.when(
              data: (items) => ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text('${item.symbol} ${item.targetDate}'),
                    subtitle: Text(item.explanation),
                    trailing: Text(item.signalStatus),
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
