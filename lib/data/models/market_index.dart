/// 指数行情数据模型 — 对应 GET /market/index
class MarketIndex {
  final String indexCode;       // 指数代码
  final String indexName;       // 指数名称
  final String trend;           // 趋势：bullish / bearish / neutral
  final List<IndexDataPoint> dataPoints; // 行情数据点

  MarketIndex({
    required this.indexCode,
    required this.indexName,
    required this.trend,
    required this.dataPoints,
  });

  factory MarketIndex.fromJson(Map<String, dynamic> json) {
    return MarketIndex(
      indexCode: json['index_code'] as String? ?? '',
      indexName: json['index_name'] as String? ?? '',
      trend: json['trend'] as String? ?? 'neutral',
      dataPoints: (json['data_points'] as List<dynamic>? ?? [])
          .map((e) => IndexDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 单个行情数据点
class IndexDataPoint {
  final String date;   // 日期 YYYY-MM-DD
  final String label;  // 显示标签（Mon / Tue / ...）
  final double value;  // 收盘点位

  IndexDataPoint({
    required this.date,
    required this.label,
    required this.value,
  });

  factory IndexDataPoint.fromJson(Map<String, dynamic> json) {
    return IndexDataPoint(
      date: json['date'] as String? ?? '',
      label: json['label'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
