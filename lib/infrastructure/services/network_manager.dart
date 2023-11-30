import 'package:dio/dio.dart';

import '../../result.dart';

class NetworkManager {
  final Dio dio = Dio();
  final String apiPath;

  NetworkManager({required this.apiPath});

  Future<Result<dynamic>> getRequest(String path) async {
    try {
      final response = await dio.get(apiPath + path);
      return Result(value: response, error: null);
    } catch (e) {
      return Result(value: null, error: Error());
    }
  }
}
