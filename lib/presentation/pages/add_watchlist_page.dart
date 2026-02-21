import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/design_system/app_text_styles.dart';
import '../../shared/widgets/widgets.dart';

/// 添加监听页
/// 配置新的股票监听
class AddWatchlistPage extends ConsumerStatefulWidget {
  const AddWatchlistPage({super.key});

  @override
  ConsumerState<AddWatchlistPage> createState() => _AddWatchlistPageState();
}

class _AddWatchlistPageState extends ConsumerState<AddWatchlistPage> {
  final _formKey = GlobalKey<FormState>();
  final _symbolController = TextEditingController();
  String? _selectedRule;
  bool _isLoading = false;

  // 示例规则选项
  final List<Map<String, String>> _ruleOptions = [
    {'id': 'rule_a', 'name': '趋势跟踪策略'},
    {'id': 'rule_b', 'name': '动量反转策略'},
    {'id': 'custom', 'name': '自定义规则'},
  ];

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: 调用实际的添加监听 UseCase
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加监听'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('股票代码', style: AppTextStyles.titleSmall),
              const SizedBox(height: 8),
              TextFormField(
                controller: _symbolController,
                decoration: const InputDecoration(
                  hintText: '输入股票代码，如 000001.SZ',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入股票代码';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Text('监听规则', style: AppTextStyles.titleSmall),
              const SizedBox(height: 8),
              ..._ruleOptions.map((rule) => RadioListTile<String>(
                    title: Text(rule['name']!),
                    value: rule['id']!,
                    groupValue: _selectedRule,
                    onChanged: (value) {
                      setState(() => _selectedRule = value);
                    },
                    contentPadding: EdgeInsets.zero,
                  )),
              const SizedBox(height: 8),
              if (_selectedRule == null && _formKey.currentState?.validate() == true)
                Text(
                  '请选择监听规则',
                  style: AppTextStyles.caption.copyWith(
                    color: const Color(0xFFD32F2F),
                  ),
                ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      // 底部操作区
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 唯一主操作按钮
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFFFFFFFF),
                          ),
                        )
                      : const Text('确认添加'),
                ),
              ),
              const SizedBox(height: 16),
              const DisclaimerFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
