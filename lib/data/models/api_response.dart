class ApiResponse<T> {
  final int code;
  final String message;
  final T data;
  final String? disclaimer;

  ApiResponse({
    required this.code,
    required this.message,
    required this.data,
    this.disclaimer,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) parser,
  ) {
    return ApiResponse<T>(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: parser(json['data']),
      disclaimer: json['disclaimer'] as String?,
    );
  }
}
