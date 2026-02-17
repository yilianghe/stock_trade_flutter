class SignalResultEntity {
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

  SignalResultEntity({
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
}
