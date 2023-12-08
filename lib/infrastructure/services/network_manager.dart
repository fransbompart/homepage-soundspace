import 'package:dio/dio.dart';

import '../../commons/result.dart';

class NetworkManager {
  final Dio dio = Dio(BaseOptions(
    baseUrl:
        'https://soundspace-api-production.up.railway.app/api/', //TODO:mejorar esto con las .env
  ));

  Future<Result<dynamic>> getRequest(String path) async {
    try {
      final response = await dio.get(path);
      return Result(value: response, error: null);
    } on DioException {
      return Result(value: null, error: Error());
    } catch (e) {
      return Result(value: null, error: Error());
    }
  }

  Future<Result<dynamic>> postRequest(String path, dynamic body) async {
    try {
      final response = await dio.post(path, data: body);
      return Result(value: response, error: null);
    } catch (e) {
      return Result(value: null, error: Error());
    }
  }
}
