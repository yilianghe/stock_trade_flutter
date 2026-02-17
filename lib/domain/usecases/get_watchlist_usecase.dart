import '../entities/watchlist_entity.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistUseCase {
  final WatchlistRepository repository;

  GetWatchlistUseCase(this.repository);

  Future<WatchlistEntity> call() {
    return repository.getWatchlist();
  }
}
