import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/core/abstracts/consumer.dart';
import 'package:keyboard/core/entities/response.dart';
import 'package:path_provider/path_provider.dart';

class DioConsumer implements Consumer {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: kServerUrl,
      followRedirects: false,
      validateStatus: (status) => (status ?? 0) < 500,
      connectTimeout: 60 * 60 * 1000,
      receiveTimeout: 0,
    ),
  );

  DioConsumer();

  @override
  Future<void> init() async {
    CacheStore store;
    if (!kIsWeb) {
      var dir = await getTemporaryDirectory();
      store = HiveCacheStore(dir.path);
    } else {
      store = MemCacheStore();
    }

    CacheOptions options = CacheOptions(
      store: store,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [],
      priority: CachePriority.normal,
      allowPostMethod: false,
    );

    _dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  @override
  Future<void> dispose() async {
    _dio.close();
  }

  @override
  Future<ResponseEntity> delete(String url) async {
    try {
      final response = await _dio.delete(
        url,
      );

      return ResponseEntity(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        data: response.data,
      );
    } catch (e) {
      print(e);
      return ResponseEntity(
        statusCode: 0,
        statusMessage: 'No connection',
        data: null,
      );
    }
  }

  @override
  Future<ResponseEntity> get(String url) async {
    try {
      final response = await _dio.get(
        url,
      );

      return ResponseEntity(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        data: response.data,
      );
    } catch (e) {
      print(e);
      return ResponseEntity(
        statusCode: 0,
        statusMessage: 'No connection',
        data: null,
      );
    }
  }

  @override
  Future<ResponseEntity> post({required String url, required data}) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
      );

      return ResponseEntity(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        data: response.data,
      );
    } catch (e) {
      print(e);
      return ResponseEntity(
        statusCode: 0,
        statusMessage: 'No connection',
        data: null,
      );
    }
  }

  @override
  Future<ResponseEntity> put({required String url, required data}) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
      );

      return ResponseEntity(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        data: response.data,
      );
    } catch (e) {
      print(e);
      return ResponseEntity(
        statusCode: 0,
        statusMessage: 'No connection',
        data: null,
      );
    }
  }
}
