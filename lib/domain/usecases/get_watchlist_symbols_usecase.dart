import '../entities/watchlist_symbols_entity.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistSymbolsUseCase {
  final WatchlistRepository repository;

  GetWatchlistSymbolsUseCase(this.repository);

  Future<WatchlistSymbolsEntity> call() {
    return repository.getSymbols();
  }
}
