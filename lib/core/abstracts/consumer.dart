import 'package:keyboard/core/entities/response.dart';
import 'package:keyboard/core/enums/fetch_types.dart';

abstract class Consumer {
  const Consumer();
  Future<void> init();
  Future<void> dispose();
  Future<ResponseEntity> get(String url);
  Future<ResponseEntity> post({required String url, required dynamic data});
  Future<ResponseEntity> put({required String url, required dynamic data});
  Future<ResponseEntity> delete(String url);
}
