import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String url}) async {
    var responce = await _dio.get(url);
    return responce.data;
  }

  Future<Map<String, dynamic>> post({
    required String url,
  }) async {
    var responce = await _dio.post(url);
    return responce.data;
  }
}
