import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj3_app/blocs/document.bloc.dart';
import 'package:prj3_app/blocs/reminder.bloc.dart';
import 'package:prj3_app/blocs/student.bloc.dart';
import 'package:prj3_app/ui/course.ui.dart';
import 'package:prj3_app/ui/document.ui.dart';
import 'package:prj3_app/ui/reminder.ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final ctrl = PageController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DocumentBloc>(context).add(DocumentInit());
    BlocProvider.of<ReminderBloc>(context).add(ReminderInit());
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: TextButton(
              onPressed: () {
                context
                  ..read<DocumentBloc>().add(DocumentReset())
                  ..read<StudentBloc>().add(StudentLogout());
              },
              child: const Text("Đăng xuất")),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(["Học phần", "Sự kiện", "Học liệu"][index],
              style: themeData.textTheme.titleMedium),
        ),
        body: PageView(
          controller: ctrl,
          onPageChanged: (value) => setState(() => index = value),
          children: const [CourseUI(), ReminderUI(), DocumentUI()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (_) {
              setState(() => index = _);
              ctrl.jumpToPage(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined), activeIcon: Icon(Icons.book), label: "Học phần"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event_outlined),
                  activeIcon: Icon(Icons.event),
                  label: "Sự kiện"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  activeIcon: Icon(Icons.archive),
                  label: "Học liệu")
            ]),
      ),
    );
  }
}
