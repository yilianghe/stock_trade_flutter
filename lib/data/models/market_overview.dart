/// 市场概览数据模型 — 对应 GET /market/overview
class MarketOverview {
  final int signalsCount;       // 当前活跃信号数量
  final int signalsChange;      // 相比前一日的变化量
  final int healthPercent;      // 系统健康度百分比
  final bool healthVerified;    // 系统是否通过校验
  final String mode;            // 运行模式：EOD / INTRADAY
  final String modeStatus;      // 模式状态：waiting / running / completed

  MarketOverview({
    required this.signalsCount,
    required this.signalsChange,
    required this.healthPercent,
    required this.healthVerified,
    required this.mode,
    required this.modeStatus,
  });

  factory MarketOverview.fromJson(Map<String, dynamic> json) {
    return MarketOverview(
      signalsCount: json['signals_count'] as int? ?? 0,
      signalsChange: json['signals_change'] as int? ?? 0,
      healthPercent: json['health_percent'] as int? ?? 0,
      healthVerified: json['health_verified'] as bool? ?? false,
      mode: json['mode'] as String? ?? 'EOD',
      modeStatus: json['mode_status'] as String? ?? 'waiting',
    );
  }
}
