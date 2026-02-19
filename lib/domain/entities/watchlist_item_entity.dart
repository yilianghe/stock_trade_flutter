class WatchlistItemEntity {
  final int id;
  final String symbol;
  final String stockName;
  final List<String> tags;
  final String? note;
  final String? addedAt;
  final String? updatedAt;
  
  // 信号状态相关
  final String? signalStatus;
  final List<String>? passedRules;
  final List<String>? failedRules;
  final String? explanation;

  WatchlistItemEntity({
    required this.id,
    required this.symbol,
    required this.stockName,
    required this.tags,
    this.note,
    this.addedAt,
    this.updatedAt,
    this.signalStatus,
    this.passedRules,
    this.failedRules,
    this.explanation,
  });
}
