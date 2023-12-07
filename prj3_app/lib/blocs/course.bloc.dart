import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/models/course.model.dart';
import 'package:prj3_app/services/apis/api.dart';

part "course.bloc.freezed.dart";

abstract class CourseEvent {}

class CourseFetch extends CourseEvent {
  CourseFetch();
}

class CourseVote extends CourseEvent {
  final String id, author;
  final int vote, oldVote;

  CourseVote(this.id, this.vote, this.author, this.oldVote);
}

@freezed
class CourseState with _$CourseState {
  factory CourseState({@Default([]) List<Course> courses}) = _CourseState;
}

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseState()) {
    on<CourseFetch>((event, emit) async {
      await Api().getCourses().then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(courses: [
            ...state.courses,
            ...(value["data"] as List).map((e) => Course.fromJson(e))
          ]));
        }
      });
    });
    add(CourseFetch());
  }
}
