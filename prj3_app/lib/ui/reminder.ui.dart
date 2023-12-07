import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prj3_app/blocs/reminder.bloc.dart';
import 'package:prj3_app/helpers/formatter.dart';
import 'package:prj3_app/models/reminder.model.dart';
import 'package:prj3_app/widgets/expandable_fab.dart';

class ReminderUI extends StatefulWidget {
  const ReminderUI({super.key});

  @override
  State<ReminderUI> createState() => _ReminderUIState();
}

class _ReminderUIState extends State<ReminderUI> with TickerProviderStateMixin {
  late final ctrl = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
                controller: ctrl,
                physics: const NeverScrollableScrollPhysics(),
                tabs: const [Text("Sự kiện"), Text("Nhắc hẹn"), Text("Mục tiêu")]),
            Expanded(
              child: TabBarView(
                controller: ctrl
                  ..addListener(() {
                    if (ctrl.index != ctrl.previousIndex) {
                      setState(() {});
                    }
                  }),
                physics: const ClampingScrollPhysics(),
                children: [
                  BlocBuilder<ReminderBloc, ReminderState>(
                    buildWhen: (previous, current) => previous.events != current.events,
                    builder: (context, state) {
                      return (state.events == null)
                          ? const Text("Đang tải sự kiện")
                          : ListView.builder(
                              itemBuilder: (context, index) =>
                                  EventCard(event: state.events![index]),
                              itemCount: state.events!.length,
                            );
                    },
                  ),
                  BlocBuilder<ReminderBloc, ReminderState>(
                    buildWhen: (previous, current) => previous.reminds != current.reminds,
                    builder: (context, state) {
                      return (state.reminds == null)
                          ? const Text("Đang tải nhắc hẹn")
                          : ListView.builder(
                              itemBuilder: (context, index) =>
                                  RemindCard(remind: state.reminds![index]),
                              itemCount: state.reminds!.length,
                            );
                    },
                  ),
                  BlocBuilder<ReminderBloc, ReminderState>(
                    buildWhen: (previous, current) => previous.targets != current.targets,
                    builder: (context, state) {
                      return (state.targets == null)
                          ? const Text("Đang tải mục tiêu")
                          : ListView.builder(
                              itemBuilder: (context, index) =>
                                  TargetCard(target: state.targets![index]),
                              itemCount: state.targets!.length,
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ctrl.index == 2
          ? ExpandableFab(distance: 70, children: [
              FloatingActionButton(
                  onPressed: () {
                    showDialog<Map<String, dynamic>>(
                        context: context, builder: (_) => const CreateTargetDialog()).then((value) {
                      if (value != null) {
                        context.read<ReminderBloc>().add(ReminderTargetAdd());
                      }
                    });
                  },
                  child: const FaIcon(FontAwesomeIcons.plus)),
              FloatingActionButton(
                  onPressed: () {}, child: const FaIcon(FontAwesomeIcons.chartLine))
            ])
          : FloatingActionButton(
              onPressed: () {
                if (ctrl.index == 0) {
                  showDialog<Map<String, dynamic>>(
                      context: context, builder: (_) => const CreateEventDialog()).then((value) {
                    if (value != null) {
                      context.read<ReminderBloc>().add(ReminderEventAdd(Event.fromJson(value)));
                    }
                  });
                } else {
                  showDialog<Map<String, dynamic>>(
                      context: context, builder: (_) => const CreateRemindDialog()).then((value) {
                    if (value != null) {
                      context.read<ReminderBloc>().add(ReminderRemindAdd(Remind.fromJson(value)));
                    }
                  });
                }
              },
              child: const FaIcon(FontAwesomeIcons.plus)),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var now = DateTime.now();
    var indicatorColor = (now.millisecondsSinceEpoch <
            event.timestamp!
                .subtract(Duration(minutes: event.preNotifyTime))
                .millisecondsSinceEpoch)
        ? themeData.colorScheme.primaryContainer
        : (now.millisecondsSinceEpoch < event.timestamp!.millisecondsSinceEpoch)
            ? Colors.yellow
            : themeData.colorScheme.error;

    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(color: indicatorColor, width: 8))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.name, style: themeData.textTheme.titleMedium),
                    Text(event.description),
                    Text("Thời điểm: ${dateTimeFormatter(event.timestamp)}.",
                        style:
                            themeData.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
                    Text("Báo trước: ${event.preNotifyTime} phút.",
                        style:
                            themeData.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic))
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                      backgroundColor: themeData.canvasColor,
                      foregroundColor: themeData.colorScheme.error,
                      shape: const CircleBorder()),
                  icon: const FaIcon(FontAwesomeIcons.trashCan))
            ],
          )),
    );
  }
}

class RemindCard extends StatelessWidget {
  final Remind remind;

  const RemindCard({super.key, required this.remind});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var now = DateTime.now();
    var indicatorColor = (remind.schedule["weekday"].contains(now.weekday))
        ? themeData.colorScheme.primaryContainer
        : themeData.colorScheme.error;

    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(color: indicatorColor, width: 8))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(remind.name, style: themeData.textTheme.titleMedium),
                    Text(remind.description),
                    Text("Thời điểm: ${timeFormatter(remind.schedule["time"])}.",
                        style:
                            themeData.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(7, (index) {
                        return ChoiceChip(
                            iconTheme: themeData.chipTheme.iconTheme?.copyWith(size: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.zero,
                            label: index == 6 ? const Text("CN") : Text("T${index + 2}"),
                            selected: remind.schedule["weekday"].contains(index + 1));
                      })),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                      backgroundColor: themeData.canvasColor,
                      foregroundColor: themeData.colorScheme.error,
                      shape: const CircleBorder()),
                  icon: const FaIcon(FontAwesomeIcons.trashCan))
            ],
          )),
    );
  }
}

class TargetCard extends StatelessWidget {
  final Target target;

  const TargetCard({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var now = DateTime.now();
    var indicatorColor = (target.isCompleted)
        ? themeData.colorScheme.primaryContainer
        : (now.millisecondsSinceEpoch < target.timestamp!.millisecondsSinceEpoch)
            ? Colors.yellow
            : themeData.colorScheme.error;

    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(color: indicatorColor, width: 8))),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(target.name, style: themeData.textTheme.titleMedium),
                        Text(target.description),
                        Text("Thời điểm: ${dateTimeFormatter(target.timestamp)}.",
                            style: themeData.textTheme.bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                          backgroundColor: themeData.canvasColor,
                          foregroundColor: themeData.colorScheme.error,
                          shape: const CircleBorder()),
                      icon: const FaIcon(FontAwesomeIcons.trashCan))
                ],
              ),
              Center(child: TextButton(onPressed: () {}, child: const Text("Hoàn thành mục tiêu")))
            ],
          )),
    );
  }
}

class CreateEventDialog extends StatefulWidget {
  const CreateEventDialog({super.key});

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final name = TextEditingController();
  final description = TextEditingController();
  var date = DateTime.now();
  var preNotifyTime = 120;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: const Text("Tạo sự kiện mới"),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 3 * 2,
          width: MediaQuery.sizeOf(context).width / 10 * 9,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Tên sự kiện")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: description,
                      decoration: const InputDecoration(labelText: "Chi tiết")),
                ),
                const Text("Thời điểm"),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: now,
                          minimumDate: now,
                          maximumDate: now.copyWith(year: 2030),
                          showDayOfWeek: false,
                          onDateTimeChanged: (date) => this.date = this
                              .date
                              .copyWith(year: date.year, month: date.month, day: date.day)),
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: true,
                          onDateTimeChanged: (date) =>
                              this.date = this.date.copyWith(hour: date.hour, minute: date.minute)),
                    )
                  ],
                )),
                const Text("Số phút báo trước"),
                DropdownButton(items: const [
                  DropdownMenuItem(
                    value: 30,
                    child: Text("30"),
                  ),
                  DropdownMenuItem(
                    value: 60,
                    child: Text("60"),
                  ),
                  DropdownMenuItem(
                    value: 90,
                    child: Text("90"),
                  ),
                  DropdownMenuItem(
                    value: 120,
                    child: Text("120"),
                  )
                ], onChanged: (value) => preNotifyTime = value ?? 120, value: preNotifyTime)
              ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, {
                  "name": name.text,
                  "description": description.text,
                  "timestamp": date.millisecondsSinceEpoch,
                  "preNotifyTime": preNotifyTime
                }),
            child: const Text("Tạo mới"))
      ],
    );
  }
}

class CreateRemindDialog extends StatefulWidget {
  const CreateRemindDialog({super.key});

  @override
  State<CreateRemindDialog> createState() => _CreateRemindDialogState();
}

class _CreateRemindDialogState extends State<CreateRemindDialog> {
  final name = TextEditingController();
  final description = TextEditingController();
  Map<String, dynamic> schedule = {"time": 0, "weekday": []};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: const Text("Tạo nhắc hẹn mới"),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 3 * 2,
          width: MediaQuery.sizeOf(context).width / 10 * 9,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Tên nhắc hẹn")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: description,
                      decoration: const InputDecoration(labelText: "Chi tiết")),
                ),
                const Text("Thời điểm"),
                Expanded(
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (date) =>
                          schedule["time"] = date.hour * 3600 + date.minute * 60),
                ),
                Wrap(
                    children: List.generate(
                  7,
                  (index) => ChoiceChip(
                    label: Text(index != 6 ? "T${index + 2}" : "CN"),
                    selected: schedule["weekday"].contains(index + 1),
                    onSelected: (value) => setState(() {
                      if (schedule["weekday"].contains(index + 1)) {
                        schedule["weekday"].remove(index + 1);
                      } else {
                        schedule["weekday"].add(index + 1);
                      }
                    }),
                  ),
                ))
              ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context,
                {"name": name.text, "description": description.text, "schedule": schedule}),
            child: const Text("Tạo mới"))
      ],
    );
  }
}

class CreateTargetDialog extends StatefulWidget {
  const CreateTargetDialog({super.key});

  @override
  State<CreateTargetDialog> createState() => _CreateTargetDialogState();
}

class _CreateTargetDialogState extends State<CreateTargetDialog> {
  final name = TextEditingController();
  final description = TextEditingController();
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      title: const Text("Tạo mục tiêu mới"),
      content: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 3 * 2,
          width: MediaQuery.sizeOf(context).width / 10 * 9,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(labelText: "Tên mục tiêu")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                      controller: description,
                      decoration: const InputDecoration(labelText: "Chi tiết")),
                ),
                const Text("Thời điểm"),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: now,
                          minimumDate: now,
                          maximumDate: now.copyWith(year: 2030),
                          showDayOfWeek: false,
                          onDateTimeChanged: (date) => this.date = this
                              .date
                              .copyWith(year: date.year, month: date.month, day: date.day)),
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: true,
                          onDateTimeChanged: (date) =>
                              this.date = this.date.copyWith(hour: date.hour, minute: date.minute)),
                    )
                  ],
                )),
              ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, {
                  "name": name.text,
                  "description": description.text,
                  "timestamp": date.millisecondsSinceEpoch,
                }),
            child: const Text("Tạo mới"))
      ],
    );
  }
}
