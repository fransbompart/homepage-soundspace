import 'package:sign_in_bloc/commons/result.dart';

abstract class IApiConnectionManager {
  final String baseUrl;
  Map<String, dynamic>? headers;
  IApiConnectionManager({
    required this.baseUrl,
    this.headers,
  });

  Future<Result<dynamic>> request(String path, String method, {dynamic body});

  void setHeaders(String key, dynamic value);
}
