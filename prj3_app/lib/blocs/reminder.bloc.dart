import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/models/reminder.model.dart';
import 'package:prj3_app/services/apis/api.dart';
import 'package:prj3_app/services/notifications/notification.dart';

part 'reminder.bloc.freezed.dart';

abstract class ReminderEvent {}

class ReminderRemindFetch extends ReminderEvent {}

class ReminderEventFetch extends ReminderEvent {}

class ReminderTargetFetch extends ReminderEvent {}

class ReminderRemindReset extends ReminderEvent {}

class ReminderEventReset extends ReminderEvent {}

class ReminderTargetReset extends ReminderEvent {}

class ReminderRemindAdd extends ReminderEvent {
  final Remind remind;

  ReminderRemindAdd(this.remind);
}

class ReminderEventAdd extends ReminderEvent {
  final Event event;

  ReminderEventAdd(this.event);
}

class ReminderTargetAdd extends ReminderEvent {}

class ReminderInit extends ReminderEvent {}

@freezed
class ReminderState with _$ReminderState {
  const factory ReminderState({List<Remind>? reminds, List<Event>? events, List<Target>? targets}) =
      _ReminderState;
}

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc() : super(const ReminderState()) {
    on<ReminderInit>((event, emit) {
      add(ReminderEventFetch());
      add(ReminderRemindFetch());
      add(ReminderTargetFetch());
    });
    on<ReminderEventFetch>((event, emit) async {
      await Api().getReminders("Event").then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          add(ReminderEventReset());
          add(ReminderRemindReset());
          add(ReminderTargetReset());
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(
              events: (value["data"]["reminders"] as List).map((e) => Event.fromJson(e)).toList()));
          for (Event element in state.events ?? []) {
            if ((element.timestamp?.compareTo(DateTime.now()) ?? 0) >= 0) {
              NotificationService.scheduleEventNotification(element);
            } else {
              print("$element is over.");
            }
          }
        }
      });
    });
    on<ReminderRemindFetch>((event, emit) async {
      await Api().getReminders("Remind").then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          add(ReminderEventReset());
          add(ReminderRemindReset());
          add(ReminderTargetReset());
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(
              reminds:
                  (value["data"]["reminders"] as List).map((e) => Remind.fromJson(e)).toList()));
          for (Remind element in state.reminds ?? []) {
            NotificationService.scheduleRemindNotification(element);
          }
        }
      });
    });
    on<ReminderTargetFetch>((event, emit) async {
      await Api().getReminders("Target").then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi xảy ra với máy chủ.");
          return;
        }
        if (value["code"].toString().startsWith("403")) {
          Fluttertoast.showToast(msg: "Bạn đã bị đăng xuất.");
          add(ReminderEventReset());
          add(ReminderRemindReset());
          add(ReminderTargetReset());
          return;
        }
        if (value["code"] == "200 - OK") {
          emit(state.copyWith(
              targets:
                  (value["data"]["reminders"] as List).map((e) => Target.fromJson(e)).toList()));
        }
      });
    });
    on<ReminderEventAdd>((event, emit) async {
      await Api().addReminders(event: event.event).then((value) {
        if ((event.event.timestamp?.compareTo(DateTime.now()) ?? 0) >= 0) {
          NotificationService.scheduleEventNotification(event.event);
        } else {
          print("${event.event} is over.");
        }
        emit(state.copyWith(events: [event.event, ...(state.events ?? [])]));
      });
    });
    on<ReminderRemindAdd>((event, emit) async {
      await Api().addReminders(remind: event.remind).then((value) {
        NotificationService.scheduleRemindNotification(event.remind);

        emit(state.copyWith(reminds: [event.remind, ...(state.reminds ?? [])]));
      });
    });
  }
}
