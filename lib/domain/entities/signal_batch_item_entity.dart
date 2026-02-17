class SignalBatchItemEntity {
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

  SignalBatchItemEntity({
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
}
