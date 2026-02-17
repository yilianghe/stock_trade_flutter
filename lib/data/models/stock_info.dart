class StockInfo {
  final String symbol;
  final String name;
  final String industry;
  final String market;
  final String listDate;

  StockInfo({
    required this.symbol,
    required this.name,
    required this.industry,
    required this.market,
    required this.listDate,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      industry: json['industry'] as String? ?? '',
      market: json['market'] as String? ?? '',
      listDate: json['list_date'] as String? ?? '',
    );
  }
}
