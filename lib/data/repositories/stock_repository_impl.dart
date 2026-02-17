import '../../domain/entities/stock_info_entity.dart';
import '../../domain/entities/stock_search_item_entity.dart';
import '../../domain/entities/stock_sync_result_entity.dart';
import '../../domain/repositories/stock_repository.dart';
import '../datasources/remote/api_client.dart';

class StockRepositoryImpl implements StockRepository {
  final ApiClient apiClient;

  StockRepositoryImpl(this.apiClient);

  @override
  Future<StockInfoEntity> getStockInfo(String symbol) async {
    final info = await apiClient.getStockInfo(symbol);
    return StockInfoEntity(
      symbol: info.symbol,
      name: info.name,
      industry: info.industry,
      market: info.market,
      listDate: info.listDate,
    );
  }

  @override
  Future<List<StockSearchItemEntity>> searchStock(String keyword) async {
    final result = await apiClient.searchStock(keyword);
    return result
        .map(
          (item) => StockSearchItemEntity(
            symbol: item.symbol,
            name: item.name,
            industry: item.industry,
          ),
        )
        .toList();
  }

  @override
  Future<StockSyncResultEntity> syncStock() async {
    final result = await apiClient.syncStock();
    return StockSyncResultEntity(syncedCount: result.syncedCount);
  }
}
