class StockSearchItem {
  final String symbol;
  final String name;
  final String industry;

  StockSearchItem({
    required this.symbol,
    required this.name,
    required this.industry,
  });

  factory StockSearchItem.fromJson(Map<String, dynamic> json) {
    return StockSearchItem(
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      industry: json['industry'] as String? ?? '',
    );
  }
}
