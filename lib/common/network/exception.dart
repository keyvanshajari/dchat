class ServerException implements Exception {
  final String message;
  final String code;
  final int? status;
  final dynamic data;

  ServerException({
    required this.message,
    required this.code,
    this.status,
    this.data,
  });

  @override
  String toString() {
    return 'ServerException(message: $message, code: $code, status: $status, data: $data)';
  }
}

class UnauthorizedException extends ServerException {
  UnauthorizedException({
    required super.message,
    super.code = 'UNAUTHORIZED',
    super.status = 403,
    super.data,
  });
}
