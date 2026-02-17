class StockSyncResult {
  final int syncedCount;

  StockSyncResult({required this.syncedCount});

  factory StockSyncResult.fromJson(Map<String, dynamic> json) {
    return StockSyncResult(
      syncedCount: json['synced_count'] as int? ?? 0,
    );
  }
}
