import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/models/reminder.model.dart';
import 'package:prj3_app/services/apis/api_root.dart';

class Api {
  Future<Map<String, dynamic>?> register({required String email, required String password}) async {
    try {
      return ApiRoot.postRequestBase(path: "/student", data: {"email": email, "password": password})
          .then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> getStudent() async {
    try {
      return ApiRoot.getRequestBase(path: "/student").then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> updateStudent(int week) async {
    try {
      return ApiRoot.putRequestBase(path: "/student", data: {"week": week})
          .then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> login({required String email, required String password}) async {
    try {
      return ApiRoot.postRequestBase(
          path: "/student/login",
          data: {"email": email, "password": password}).then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> getDocuments(
      {int limit = 10,
      int offset = -1,
      List<String> tags = const [],
      int sort = 0,
      String name = "",
      String originalName = ""}) async {
    try {
      return ApiRoot.getRequestBase(path: "/document", queryParameters: {
        "limit": limit,
        "offset": offset,
        "tags": jsonEncode(tags),
        "sort": 0,
        "name": name,
        "originalName": originalName
      }).then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> downloadDocument(
      {required String name, required Function(int, int)? onReceivedProgress}) async {
    var status = await Permission.storage.status;
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return {};
    } else if (status != PermissionStatus.granted) {
      if (await Permission.storage.request() != PermissionStatus.granted) return {};
    }
    try {
      return ApiRoot.client(null)
          .download("/file/view/$name", "$dataPath/$name", onReceiveProgress: onReceivedProgress)
          .then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> voteDocument(String id, int vote, [int oldVote = 0]) async {
    try {
      return ApiRoot.putRequestBase(
          path: "/document/vote",
          data: {"id": id, "vote": vote, "oldVote": oldVote}).then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> getTags() async {
    try {
      return ApiRoot.getRequestBase(path: "/document/tags").then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> getReminders(String type) async {
    try {
      return ApiRoot.getRequestBase(path: "/reminder", queryParameters: {"type": type})
          .then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> getCourses() async {
    try {
      return ApiRoot.getRequestBase(path: "/course").then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> createCourse(Map<String, dynamic> json) async {
    try {
      return ApiRoot.postRequestBase(path: "/course", data: json).then((value) => value.data);
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>?> addReminders({Event? event, Remind? remind, Target? target}) async {
    if (event != null) {
      try {
        return ApiRoot.postRequestBase(path: "/reminder", data: {
          "type": "Event",
          ...Map.fromEntries(event.toJson().entries.where((element) => element.key != "createdAt"))
        }).then((value) {
          return (value.data);
        });
      } on DioException catch (e) {
        return e.response?.data;
      }
    }
    if (remind != null) {
      try {
        return ApiRoot.postRequestBase(path: "/reminder", data: {
          "type": "Remind",
          ...Map.fromEntries(remind.toJson().entries.where((element) => element.key != "createdAt"))
        }).then((value) {
          return (value.data);
        });
      } on DioException catch (e) {
        return e.response?.data;
      }
    }
    return null;
  }
}
