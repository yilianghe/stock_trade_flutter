import '../entities/watchlist_delete_result_entity.dart';
import '../repositories/watchlist_repository.dart';

class DeleteWatchlistItemUseCase {
  final WatchlistRepository repository;

  DeleteWatchlistItemUseCase(this.repository);

  Future<WatchlistDeleteResultEntity> call(String symbol) {
    return repository.deleteItem(symbol);
  }
}
