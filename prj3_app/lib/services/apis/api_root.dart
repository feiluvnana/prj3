import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prj3_app/main.dart';

class ApiRoot {
  static Dio client(String? authorization) {
    return Dio(BaseOptions(
        baseUrl: "http://localhost:3802",
        headers: {
          "Content-Type": "application/json",
          if (authorization != null) "Authorization": "Bearer $authorization"
        },
        validateStatus: (status) => true));
  }

  static Future<Response<Map<String, dynamic>>> getRequestBase(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Function(int current, int total)? onReceiveProgress}) async {
    return client(await storage.read(key: "token")).get<Map<String, dynamic>>(path,
        queryParameters: queryParameters, onReceiveProgress: onReceiveProgress);
  }

  static Future<Response<Map<String, dynamic>>> postRequestBase(
      {required String path,
      required Map<String, dynamic> data,
      Function(int current, int total)? onReceiveProgress}) async {
    return client(await storage.read(key: "token")).post<Map<String, dynamic>>(path,
        data: jsonEncode(data), onReceiveProgress: onReceiveProgress);
  }
}
