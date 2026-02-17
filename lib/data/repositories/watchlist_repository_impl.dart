import '../../domain/entities/watchlist_delete_result_entity.dart';
import '../../domain/entities/watchlist_entity.dart';
import '../../domain/entities/watchlist_item_entity.dart';
import '../../domain/entities/watchlist_symbols_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/remote/api_client.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final ApiClient apiClient;

  WatchlistRepositoryImpl(this.apiClient);

  @override
  Future<WatchlistEntity> getWatchlist() async {
    final result = await apiClient.getWatchlist();
    return WatchlistEntity(
      total: result.total,
      items: result.watchlist
          .map(
            (item) => WatchlistItemEntity(
              id: item.id,
              symbol: item.symbol,
              stockName: item.stockName,
              tags: item.tags,
              note: item.note,
              addedAt: item.addedAt,
              updatedAt: item.updatedAt,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<WatchlistSymbolsEntity> getSymbols() async {
    final result = await apiClient.getWatchlistSymbols();
    return WatchlistSymbolsEntity(total: result.total, symbols: result.symbols);
  }

  @override
  Future<WatchlistItemEntity> getItem(String symbol) async {
    final item = await apiClient.getWatchlistItem(symbol);
    return WatchlistItemEntity(
      id: item.id,
      symbol: item.symbol,
      stockName: item.stockName,
      tags: item.tags,
      note: item.note,
      addedAt: item.addedAt,
      updatedAt: item.updatedAt,
    );
  }

  @override
  Future<WatchlistItemEntity> addItem({
    required String symbol,
    required List<String> tags,
    String? note,
  }) async {
    final item = await apiClient.addWatchlistItem(symbol: symbol, tags: tags, note: note);
    return WatchlistItemEntity(
      id: item.id,
      symbol: item.symbol,
      stockName: item.stockName,
      tags: item.tags,
      note: item.note,
      addedAt: item.addedAt,
      updatedAt: item.updatedAt,
    );
  }

  @override
  Future<WatchlistItemEntity> updateItem({
    required String symbol,
    required List<String> tags,
    String? note,
  }) async {
    final item = await apiClient.updateWatchlistItem(symbol: symbol, tags: tags, note: note);
    return WatchlistItemEntity(
      id: item.id,
      symbol: item.symbol,
      stockName: item.stockName,
      tags: item.tags,
      note: item.note,
      addedAt: item.addedAt,
      updatedAt: item.updatedAt,
    );
  }

  @override
  Future<WatchlistDeleteResultEntity> deleteItem(String symbol) async {
    final result = await apiClient.deleteWatchlistItem(symbol);
    return WatchlistDeleteResultEntity(symbol: result.symbol, success: result.success);
  }
}
