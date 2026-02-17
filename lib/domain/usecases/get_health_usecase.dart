import '../entities/health_status_entity.dart';
import '../repositories/system_repository.dart';

class GetHealthUseCase {
  final SystemRepository repository;

  GetHealthUseCase(this.repository);

  Future<HealthStatusEntity> call() {
    return repository.getHealth();
  }
}
