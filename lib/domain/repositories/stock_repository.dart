import '../entities/stock_info_entity.dart';
import '../entities/stock_search_item_entity.dart';
import '../entities/stock_sync_result_entity.dart';

abstract class StockRepository {
  Future<StockInfoEntity> getStockInfo(String symbol);
  Future<List<StockSearchItemEntity>> searchStock(String keyword);
  Future<StockSyncResultEntity> syncStock();
}
