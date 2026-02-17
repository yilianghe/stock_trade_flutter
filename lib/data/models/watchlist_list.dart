import 'watchlist_item.dart';

class WatchlistList {
  final int total;
  final List<WatchlistItem> watchlist;

  WatchlistList({
    required this.total,
    required this.watchlist,
  });

  factory WatchlistList.fromJson(Map<String, dynamic> json) {
    final items = (json['watchlist'] as List<dynamic>? ?? [])
        .map((e) => WatchlistItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return WatchlistList(
      total: json['total'] as int? ?? items.length,
      watchlist: items,
    );
  }
}
