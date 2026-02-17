class SignalHistoryItemEntity {
  final String symbol;
  final String targetDate;
  final String signalStatus;
  final String strategyName;
  final String explanation;
  final String executedAt;

  SignalHistoryItemEntity({
    required this.symbol,
    required this.targetDate,
    required this.signalStatus,
    required this.strategyName,
    required this.explanation,
    required this.executedAt,
  });
}
