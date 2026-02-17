class WatchlistDeleteResult {
  final String symbol;
  final bool success;

  WatchlistDeleteResult({
    required this.symbol,
    required this.success,
  });

  factory WatchlistDeleteResult.fromJson(Map<String, dynamic> json) {
    return WatchlistDeleteResult(
      symbol: json['symbol'] as String? ?? '',
      success: json['success'] as bool? ?? false,
    );
  }
}
