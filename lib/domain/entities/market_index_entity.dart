/// 指数行情业务实体
class MarketIndexEntity {
  final String indexCode;
  final String indexName;
  final String trend;
  final List<IndexDataPointEntity> dataPoints;

  MarketIndexEntity({
    required this.indexCode,
    required this.indexName,
    required this.trend,
    required this.dataPoints,
  });
}

/// 单个行情数据点实体
class IndexDataPointEntity {
  final String date;
  final String label;
  final double value;

  IndexDataPointEntity({
    required this.date,
    required this.label,
    required this.value,
  });
}
