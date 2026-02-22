/// 市场概览业务实体
class MarketOverviewEntity {
  final int signalsCount;
  final int signalsChange;
  final int healthPercent;
  final bool healthVerified;
  final String mode;
  final String modeStatus;

  MarketOverviewEntity({
    required this.signalsCount,
    required this.signalsChange,
    required this.healthPercent,
    required this.healthVerified,
    required this.mode,
    required this.modeStatus,
  });
}
