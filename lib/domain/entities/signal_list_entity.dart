/// 信号列表业务实体
class SignalListEntity {
  final int total;
  final List<SignalListItemEntity> items;

  SignalListEntity({
    required this.total,
    required this.items,
  });
}

/// 信号列表项实体
class SignalListItemEntity {
  final String id;
  final String symbol;
  final String name;
  final double price;
  final double change;
  final String timestamp;
  final String status;
  final List<SignalRuleEntity> rules;

  SignalListItemEntity({
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

/// 信号规则实体
class SignalRuleEntity {
  final String name;
  final String description;
  final bool satisfied;
  final String value;
  final String threshold;

  SignalRuleEntity({
    required this.name,
    required this.description,
    required this.satisfied,
    required this.value,
    required this.threshold,
  });
}
