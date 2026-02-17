class HealthStatus {
  final String status;
  final String app;
  final String? disclaimer;

  HealthStatus({
    required this.status,
    required this.app,
    this.disclaimer,
  });

  factory HealthStatus.fromJson(Map<String, dynamic> json) {
    return HealthStatus(
      status: json['status'] as String? ?? '',
      app: json['app'] as String? ?? '',
      disclaimer: json['disclaimer'] as String?,
    );
  }
}
