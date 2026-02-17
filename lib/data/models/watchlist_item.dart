class WatchlistItem {
  final int id;
  final String symbol;
  final String stockName;
  final List<String> tags;
  final String? note;
  final String? addedAt;
  final String? updatedAt;

  WatchlistItem({
    required this.id,
    required this.symbol,
    required this.stockName,
    required this.tags,
    this.note,
    this.addedAt,
    this.updatedAt,
  });

  factory WatchlistItem.fromJson(Map<String, dynamic> json) {
    return WatchlistItem(
      id: json['id'] as int? ?? 0,
      symbol: json['symbol'] as String? ?? '',
      stockName: json['stock_name'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      note: json['note'] as String?,
      addedAt: json['added_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
