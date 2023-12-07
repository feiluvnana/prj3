import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/models/student.model.dart';
import 'package:prj3_app/services/apis/api.dart';

part "student.bloc.freezed.dart";

abstract class StudentEvent {}

class StudentRegister extends StudentEvent {
  final String email, password;
  StudentRegister({required this.email, required this.password});
}

class StudentLogin extends StudentEvent {
  final String email, password;
  StudentLogin({required this.email, required this.password});
}

class StudentLogout extends StudentEvent {}

class _StudentInit extends StudentEvent {}

@freezed
class StudentState with _$StudentState {
  factory StudentState({Student? student, @Default(false) bool authenticating}) = _StudentState;
}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentState()) {
    on<_StudentInit>((event, emit) async {
      emit(state.copyWith(authenticating: true));
      await storage.read(key: "token").then((value) async {
        var isTokenInvalid = true;
        if (value == null) {
          emit(state.copyWith(authenticating: false));
          return;
        }
        if (DateTime.fromMillisecondsSinceEpoch(jsonDecode(value)["expiredAt"] as int)
                .compareTo(DateTime.now()) >
            0) {
          var data = await Api().getStudent();
          if (data?["data"] != null) {
            isTokenInvalid = false;
            emit(state.copyWith(student: Student.fromJson(data?["data"])));
          }
        }
        if (isTokenInvalid) storage.delete(key: "token");
        emit(state.copyWith(authenticating: false));
      });
    });
    on<StudentRegister>((event, emit) async {
      var response = await Api().register(email: event.email, password: event.password);
      Fluttertoast.showToast(msg: response.toString());
    });
    on<StudentLogin>((event, emit) async {
      emit(state.copyWith(authenticating: true));
      var response = await Api().login(email: event.email, password: event.password);
      Fluttertoast.showToast(msg: response.toString());
      if (response!["code"].toString().contains("200")) {
        await storage.write(key: "token", value: jsonEncode(response["data"]));
        emit(state.copyWith(
            student: Student.fromJson(await Api().getStudent().then((value) => value?["data"]))));
      }
      emit(state.copyWith(authenticating: false));
    });
    on<StudentLogout>((event, emit) async {
      await storage.delete(key: "token");
      emit(state.copyWith(authenticating: false, student: null));
    });
    add(_StudentInit());
  }

  @override
  void onChange(Change<StudentState> change) {
    super.onChange(change);
    if (change.currentState.student != null && change.nextState.student == null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else if (change.currentState.student == null && change.nextState.student != null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }
}
