class SignalBatchItem {
  final String symbol;
  final String? mode;
  final String? targetDate;
  final String? signalStatus;
  final List<String> passedRules;
  final List<String> failedRules;
  final List<dynamic> ruleDetails;
  final String? explanation;
  final String? strategyName;
  final String? executedAt;
  final String? disclaimer;
  final String? error;

  SignalBatchItem({
    required this.symbol,
    this.mode,
    this.targetDate,
    this.signalStatus,
    required this.passedRules,
    required this.failedRules,
    required this.ruleDetails,
    this.explanation,
    this.strategyName,
    this.executedAt,
    this.disclaimer,
    this.error,
  });

  factory SignalBatchItem.fromJson(Map<String, dynamic> json) {
    return SignalBatchItem(
      symbol: json['symbol'] as String? ?? '',
      mode: json['mode'] as String?,
      targetDate: json['target_date'] as String?,
      signalStatus: json['signal_status'] as String?,
      passedRules: (json['passed_rules'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      failedRules: (json['failed_rules'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      ruleDetails: json['rule_details'] as List<dynamic>? ?? [],
      explanation: json['explanation'] as String?,
      strategyName: json['strategy_name'] as String?,
      executedAt: json['executed_at'] as String?,
      disclaimer: json['disclaimer'] as String?,
      error: json['error'] as String?,
    );
  }
}
