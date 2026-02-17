class WatchlistItemEntity {
  final int id;
  final String symbol;
  final String stockName;
  final List<String> tags;
  final String? note;
  final String? addedAt;
  final String? updatedAt;

  WatchlistItemEntity({
    required this.id,
    required this.symbol,
    required this.stockName,
    required this.tags,
    this.note,
    this.addedAt,
    this.updatedAt,
  });
}
