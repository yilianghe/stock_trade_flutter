class SignalHistoryItem {
  final String symbol;
  final String targetDate;
  final String signalStatus;
  final String strategyName;
  final String explanation;
  final String executedAt;

  SignalHistoryItem({
    required this.symbol,
    required this.targetDate,
    required this.signalStatus,
    required this.strategyName,
    required this.explanation,
    required this.executedAt,
  });

  factory SignalHistoryItem.fromJson(Map<String, dynamic> json) {
    return SignalHistoryItem(
      symbol: json['symbol'] as String? ?? '',
      targetDate: json['target_date'] as String? ?? '',
      signalStatus: json['signal_status'] as String? ?? '',
      strategyName: json['strategy_name'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      executedAt: json['executed_at'] as String? ?? '',
    );
  }
}
