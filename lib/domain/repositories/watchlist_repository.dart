import '../entities/watchlist_delete_result_entity.dart';
import '../entities/watchlist_entity.dart';
import '../entities/watchlist_item_entity.dart';
import '../entities/watchlist_symbols_entity.dart';

abstract class WatchlistRepository {
  Future<WatchlistEntity> getWatchlist();
  Future<WatchlistSymbolsEntity> getSymbols();
  Future<WatchlistItemEntity> getItem(String symbol);
  Future<WatchlistItemEntity> addItem({
    required String symbol,
    required List<String> tags,
    String? note,
  });
  Future<WatchlistItemEntity> updateItem({
    required String symbol,
    required List<String> tags,
    String? note,
  });
  Future<WatchlistDeleteResultEntity> deleteItem(String symbol);
}
