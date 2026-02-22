/// 策略列表响应模型 — 对应 GET /strategies
class StrategyListResponse {
  final List<StrategyItem> items;

  StrategyListResponse({required this.items});

  factory StrategyListResponse.fromJson(Map<String, dynamic> json) {
    return StrategyListResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => StrategyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 策略单项
class StrategyItem {
  final String id;           // 策略唯一 ID
  final String name;         // 策略名称
  final String description;  // 策略描述
  final String mode;         // 运行模式：EOD / INTRADAY
  final List<String> rules;  // 规则表达式列表
  final String lastRun;      // 最近一次运行时间
  final bool active;         // 是否激活

  StrategyItem({
    required this.id,
    required this.name,
    required this.description,
    required this.mode,
    required this.rules,
    required this.lastRun,
    required this.active,
  });

  factory StrategyItem.fromJson(Map<String, dynamic> json) {
    return StrategyItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      mode: json['mode'] as String? ?? 'EOD',
      rules: (json['rules'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      lastRun: json['last_run'] as String? ?? '',
      active: json['active'] as bool? ?? false,
    );
  }
}
