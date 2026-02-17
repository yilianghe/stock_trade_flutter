import '../entities/watchlist_item_entity.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistItemUseCase {
  final WatchlistRepository repository;

  GetWatchlistItemUseCase(this.repository);

  Future<WatchlistItemEntity> call(String symbol) {
    return repository.getItem(symbol);
  }
}
