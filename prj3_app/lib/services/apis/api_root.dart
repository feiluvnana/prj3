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
    try {
      return client(
              await storage.read(key: "token").then((value) => jsonDecode(value ?? "{}")["value"]))
          .get<Map<String, dynamic>>(path,
              queryParameters: queryParameters, onReceiveProgress: onReceiveProgress)
          .then((value) {
        print(
            "Request: GET ${value.statusCode} ${value.realUri}\nQuery:$queryParameters\nResponse: ${value.data}");
        return value;
      });
    } on DioException catch (e) {
      print(
          "Request: GET ${e.response?.statusCode} ${e.response?.realUri}\nQuery:$queryParameters\nResponse: ${e.response?.data}");
      return e.response?.data;
    }
  }

  static Future<Response<Map<String, dynamic>>> postRequestBase(
      {required String path,
      required dynamic data,
      Function(int current, int total)? onReceiveProgress}) async {
    try {
      return client(
              await storage.read(key: "token").then((value) => jsonDecode(value ?? "{}")["value"]))
          .post<Map<String, dynamic>>(path, data: data, onReceiveProgress: onReceiveProgress)
          .then((value) {
        print(
            "Request: POST ${value.statusCode} ${value.realUri}\nPayload:$data\nResponse: ${value.data}");
        return value;
      });
    } on DioException catch (e) {
      print(
          "Request: POST ${e.response?.statusCode} ${e.response?.realUri}\nPayload:$data\nResponse: ${e.response?.data}");
      return e.response?.data;
    }
  }

  static Future<Response<Map<String, dynamic>>> putRequestBase(
      {required String path,
      required dynamic data,
      Function(int current, int total)? onReceiveProgress}) async {
    try {
      return client(
              await storage.read(key: "token").then((value) => jsonDecode(value ?? "{}")["value"]))
          .put<Map<String, dynamic>>(path, data: data, onReceiveProgress: onReceiveProgress)
          .then((value) {
        print(
            "Request: PUT ${value.statusCode} ${value.realUri}\nPayload:$data\nResponse: ${value.data}");
        return value;
      });
    } on DioException catch (e) {
      print(
          "Request: PUT ${e.response?.statusCode} ${e.response?.realUri}\nPayload:$data\nResponse: ${e.response?.data}");
      return e.response?.data;
    }
  }
}
