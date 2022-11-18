class ResponseEntity {
  final int statusCode;
  final String statusMessage;
  final dynamic data;

  ResponseEntity({
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });
}