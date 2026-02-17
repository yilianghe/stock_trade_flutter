import 'watchlist_item_entity.dart';

class WatchlistEntity {
  final int total;
  final List<WatchlistItemEntity> items;

  WatchlistEntity({
    required this.total,
    required this.items,
  });
}
