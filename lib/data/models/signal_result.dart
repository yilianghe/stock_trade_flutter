class SignalResult {
  final String symbol;
  final String mode;
  final String targetDate;
  final String signalStatus;
  final List<String> passedRules;
  final List<String> failedRules;
  final List<dynamic> ruleDetails;
  final String explanation;
  final String strategyName;
  final String executedAt;
  final String? disclaimer;

  SignalResult({
    required this.symbol,
    required this.mode,
    required this.targetDate,
    required this.signalStatus,
    required this.passedRules,
    required this.failedRules,
    required this.ruleDetails,
    required this.explanation,
    required this.strategyName,
    required this.executedAt,
    this.disclaimer,
  });

  factory SignalResult.fromJson(Map<String, dynamic> json) {
    return SignalResult(
      symbol: json['symbol'] as String? ?? '',
      mode: json['mode'] as String? ?? '',
      targetDate: json['target_date'] as String? ?? '',
      signalStatus: json['signal_status'] as String? ?? '',
      passedRules: (json['passed_rules'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      failedRules: (json['failed_rules'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      ruleDetails: json['rule_details'] as List<dynamic>? ?? [],
      explanation: json['explanation'] as String? ?? '',
      strategyName: json['strategy_name'] as String? ?? '',
      executedAt: json['executed_at'] as String? ?? '',
      disclaimer: json['disclaimer'] as String?,
    );
  }
}
