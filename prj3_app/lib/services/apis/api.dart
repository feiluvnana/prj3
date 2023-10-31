import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/services/apis/api_root.dart';

class Api {
  Future<Map<String, dynamic>> register({required String email, required String password}) async {
    try {
      return ApiRoot.postRequestBase(path: "/account", data: {"email": email, "password": password})
          .then((value) => value.data ?? {});
    } on DioException catch (e) {
      return e.response?.data ?? {};
    }
  }

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    try {
      return ApiRoot.postRequestBase(
          path: "/account/login",
          data: {"email": email, "password": password}).then((value) => value.data ?? {});
    } on DioException catch (e) {
      return e.response?.data ?? {};
    }
  }

  Future<Map<String, dynamic>> getDocuments({int limit = 10, int offset = -1}) {
    try {
      return ApiRoot.getRequestBase(
          path: "/file",
          queryParameters: {"limit": limit, "offset": offset}).then((value) => value.data ?? {});
    } on DioException catch (e) {
      return e.response?.data ?? {};
    }
  }

  Future<Map<String, dynamic>> downloadDocument(
      {required String name, required Function(int, int)? onReceivedProgress}) async {
    try {
      return ApiRoot.client(null)
          .download("/file/view/$name", "$dataPath/$name", onReceiveProgress: onReceivedProgress)
          .then((value) => {});
    } on DioException catch (e) {
      return e.response?.data ?? {};
    }
  }
}
