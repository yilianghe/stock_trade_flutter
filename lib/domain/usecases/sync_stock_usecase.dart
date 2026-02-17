import '../entities/stock_sync_result_entity.dart';
import '../repositories/stock_repository.dart';

class SyncStockUseCase {
  final StockRepository repository;

  SyncStockUseCase(this.repository);

  Future<StockSyncResultEntity> call() {
    return repository.syncStock();
  }
}
