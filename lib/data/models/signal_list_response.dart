/// 信号列表响应模型 — 对应 GET /signals
class SignalListResponse {
  final int total;                    // 信号总数
  final List<SignalListItem> items;   // 信号列表

  SignalListResponse({
    required this.total,
    required this.items,
  });

  factory SignalListResponse.fromJson(Map<String, dynamic> json) {
    return SignalListResponse(
      total: json['total'] as int? ?? 0,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => SignalListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 信号列表单项
class SignalListItem {
  final String id;         // 信号唯一 ID
  final String symbol;     // 股票代码
  final String name;       // 股票名称
  final double price;      // 当前/收盘价格
  final double change;     // 涨跌幅百分比
  final String timestamp;  // 信号时间
  final String status;     // 状态：triggered / pending / failed
  final List<SignalRuleItem> rules; // 规则列表

  SignalListItem({
    required this.id,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.timestamp,
    required this.status,
    required this.rules,
  });

  factory SignalListItem.fromJson(Map<String, dynamic> json) {
    return SignalListItem(
      id: json['id'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      change: (json['change'] as num?)?.toDouble() ?? 0.0,
      timestamp: json['timestamp'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      rules: (json['rules'] as List<dynamic>? ?? [])
          .map((e) => SignalRuleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 信号规则项
class SignalRuleItem {
  final String name;        // 规则名称
  final String description; // 规则描述
  final bool satisfied;     // 是否满足
  final String value;       // 实际值
  final String threshold;   // 阈值

  SignalRuleItem({
    required this.name,
    required this.description,
    required this.satisfied,
    required this.value,
    required this.threshold,
  });

  factory SignalRuleItem.fromJson(Map<String, dynamic> json) {
    return SignalRuleItem(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      satisfied: json['satisfied'] as bool? ?? false,
      value: json['value'] as String? ?? '',
      threshold: json['threshold'] as String? ?? '',
    );
  }
}
