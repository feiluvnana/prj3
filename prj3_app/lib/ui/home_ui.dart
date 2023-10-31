import 'package:flutter/material.dart';
import 'package:prj3_app/ui/document_ui.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(["Học phần", "Sự kiện", "Học liệu"][index],
              style: themeData.textTheme.titleMedium),
          actions: switch (index) {
            0 => [
                IconButton(onPressed: () {}, icon: const Icon(Icons.schedule)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.query_stats))
              ],
            1 => [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
            _ => [
                IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
              ]
          },
        ),
        body: PageView(
          controller: ctrl,
          onPageChanged: (value) => setState(() => index = value),
          children: [Container(), Container(), const DocumentUI()],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
