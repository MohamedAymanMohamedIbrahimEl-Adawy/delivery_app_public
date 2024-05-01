class AppResponse {
  Map<String, dynamic>? data;
  final bool hasError;
  String? message;

  AppResponse({
    this.data,
    required this.hasError,
    this.message,
  });

  factory AppResponse.withSuccess({
    Map<String, dynamic>? data,
    String? message,
  }) {
    return AppResponse(
      hasError: false,
      data: data,
      message: message,
    );
  }

  factory AppResponse.withError({
    Map<String, dynamic>? data,
    String? message,
  }) {
    return AppResponse(
      hasError: true,
      data: data,
      message: message,
    );
  }
}
