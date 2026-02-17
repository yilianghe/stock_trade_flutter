class SignalRequest {
  final String symbol;
  final String targetDate;
  final String strategyName;

  SignalRequest({
    required this.symbol,
    required this.targetDate,
    required this.strategyName,
  });

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'target_date': targetDate,
      'strategy_name': strategyName,
    };
  }
}
