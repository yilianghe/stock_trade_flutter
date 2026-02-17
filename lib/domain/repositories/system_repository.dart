import '../entities/health_status_entity.dart';

abstract class SystemRepository {
  Future<HealthStatusEntity> getHealth();
}
