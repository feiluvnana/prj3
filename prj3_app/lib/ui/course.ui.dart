import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj3_app/blocs/course.bloc.dart';
import 'package:prj3_app/models/course.model.dart';
import 'package:prj3_app/services/apis/api.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CourseUI extends StatefulWidget {
  const CourseUI({super.key});

  @override
  State<CourseUI> createState() => _CourseUIState();
}

class _CourseUIState extends State<CourseUI> {
  int currentWeek = 0;
  Semester? currentSemester;
  DateTime currentDate = DateTime.now();
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
        List<Semester> semester = state.courses.map((e) => e.semester).toSet().toList();
        return Column(
          children: [
            Row(children: [
              const Text("Học kỳ: "),
              DropdownButton(
                  value: currentSemester,
                  items: List.generate(
                      semester.length,
                      (index) => DropdownMenuItem(
                            value: semester[index],
                            child: Text(semester[index].name),
                            onTap: () {},
                          )),
                  onChanged: (value) {
                    setState(() {
                      currentWeek = DateTime.now()
                                  .difference(
                                      DateTime.fromMillisecondsSinceEpoch(value?.start ?? 0))
                                  .inDays ~/
                              7 +
                          1;
                      isFirstTime = true;
                      currentSemester = value!;
                    });
                  }),
              Text("Tuần: $currentWeek")
            ]),
            Builder(builder: (context) {
              List<Appointment> appointments = [];
              List<Course> courses =
                  state.courses.where((element) => element.semester == currentSemester).toList();
              for (var c in courses) {
                if (c.schedule.week.contains(currentWeek)) {
                  appointments.add(Appointment(
                      startTime: currentDate
                          .subtract(Duration(days: currentDate.weekday - c.schedule.weekday))
                          .copyWith(
                              hour: c.schedule.start ~/ 3600,
                              minute: c.schedule.start % 3600 ~/ 60),
                      endTime: currentDate
                          .subtract(Duration(days: currentDate.weekday - c.schedule.weekday))
                          .copyWith(
                              hour: c.schedule.end ~/ 3600, minute: c.schedule.end % 3600 ~/ 60),
                      subject: c.name));
                }
              }
              return SfCalendar(
                initialDisplayDate: currentDate,
                minDate: DateTime.fromMillisecondsSinceEpoch(currentSemester?.start ?? 0)
                    .subtract(const Duration(days: 7)),
                maxDate: DateTime.fromMillisecondsSinceEpoch(currentSemester?.start ?? 0)
                    .add(const Duration(days: 40 * 7)),
                onViewChanged: (details) {
                  if (isFirstTime) {
                    isFirstTime = false;
                    return;
                  }
                  if (details.visibleDates.contains(
                      currentDate.copyWith(hour: 0, minute: 0, microsecond: 0, millisecond: 0))) {
                    return;
                  }
                  if (details.visibleDates[0].isAfter(currentDate)) {
                    setState(() {
                      currentWeek = currentWeek + 1;
                      currentDate = currentDate.add(const Duration(days: 7));
                    });
                  } else if (details.visibleDates[0].isBefore(currentDate)) {
                    setState(() {
                      currentWeek = currentWeek - 1;
                      currentDate = currentDate.subtract(const Duration(days: 7));
                    });
                  }
                },
                view: CalendarView.workWeek,
                dataSource: CourseDataSource(appointments),
                timeSlotViewSettings:
                    const TimeSlotViewSettings(startHour: 6, endHour: 18, timeFormat: "HH:mm"),
              );
            })
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const CreateCourseDialog();
                }).then((value) async => print(await Api().createCourse(value)));
          },
          child: const Icon(Icons.add)),
    );
  }
}

class CourseDataSource extends CalendarDataSource {
  CourseDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CreateCourseDialog extends StatefulWidget {
  const CreateCourseDialog({super.key});

  @override
  State<CreateCourseDialog> createState() => _CreateCourseDialogState();
}

class _CreateCourseDialogState extends State<CreateCourseDialog> {
  final name = TextEditingController();
  final courseId = TextEditingController();
  final midFactor = TextEditingController();
  final courseFactor = TextEditingController();
  final week = TextEditingController();
  final semesterName = TextEditingController();
  int weekday = -1;
  int start = 0, end = 0;
  var semesterDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: const Text("Tạo học phần mới"),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height / 3 * 2,
        width: MediaQuery.sizeOf(context).width / 10 * 9,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Tên khóa học")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: courseId,
                      decoration: const InputDecoration(labelText: "Mã khóa học")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: midFactor,
                      decoration: const InputDecoration(labelText: "Hệ số điểm quá trình")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: week,
                      decoration: const InputDecoration(labelText: "Các tuần học")),
                ),
                const Text("Các ngày học"),
                Wrap(
                    children: List.generate(
                  7,
                  (index) => ChoiceChip(
                    label: Text(index != 6 ? "T${index + 2}" : "CN"),
                    selected: weekday == index,
                    onSelected: (value) => setState(() {
                      weekday = value ? index : -1;
                    }),
                  ),
                )),
                const Text("Giờ bắt đầu học"),
                AspectRatio(
                  aspectRatio: 2,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (date) => start = date.hour * 3600 + date.minute * 60),
                ),
                const Text("Giờ kết thúc học"),
                AspectRatio(
                  aspectRatio: 2,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (date) => end = date.hour * 3600 + date.minute * 60),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: courseFactor,
                      decoration: const InputDecoration(labelText: "Số tín chỉ")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: semesterName,
                      decoration: const InputDecoration(labelText: "Tên học kỳ")),
                ),
                const Text("Ngày bắt đầu học kỳ"),
                AspectRatio(
                  aspectRatio: 2,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: now,
                      showDayOfWeek: false,
                      onDateTimeChanged: (date) => semesterDate =
                          semesterDate.copyWith(year: date.year, month: date.month, day: date.day)),
                ),
              ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, {
                  "id": courseId.text,
                  "name": name.text,
                  "midFactor": double.parse(midFactor.text),
                  "courseFactor": double.parse(courseFactor.text),
                  "schedule": {
                    "weekday": weekday + 1,
                    "start": start,
                    "end": end,
                    "week": textToList(week.text)
                  },
                  "semester": {
                    "name": semesterName.text,
                    "start": semesterDate.millisecondsSinceEpoch,
                  }
                }),
            child: const Text("Tạo mới"))
      ],
    );
  }

  List<int> textToList(String text) {
    List<String> segment = text.split(",");
    List<int> result = [];
    for (String s in segment) {
      if (s.contains("-")) {
        int begin = int.parse(s.split("-")[0]);
        int end = int.parse(s.split("-")[1]);
        result.addAll(List.generate(end - begin + 1, (index) => index + begin));
      } else {
        result.add(int.parse(s));
      }
    }
    return result;
  }
}
