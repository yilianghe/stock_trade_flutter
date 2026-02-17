class WatchlistSymbols {
  final int total;
  final List<String> symbols;

  WatchlistSymbols({
    required this.total,
    required this.symbols,
  });

  factory WatchlistSymbols.fromJson(Map<String, dynamic> json) {
    final list = (json['symbols'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    return WatchlistSymbols(
      total: json['total'] as int? ?? list.length,
      symbols: list,
    );
  }
}
