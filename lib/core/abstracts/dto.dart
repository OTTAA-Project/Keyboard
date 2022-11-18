abstract class DTO<T> {
  final int status;
  final String message;
  T? data;

  DTO(this.status, this.message, {this.data});

  @override
  String toString() {
    return 'DTO{status: $status, message: $message, data: $data}';
  }
}
