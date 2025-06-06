class HttpException implements Exception {
  final int? statusCode;
  final String message;

  HttpException({this.statusCode, required this.message});

  @override
  String toString() => message;
}
