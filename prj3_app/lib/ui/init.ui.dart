import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:prj3_app/main.dart';

class InitUI extends StatefulWidget {
  const InitUI({super.key});

  @override
  State<InitUI> createState() => _InitUIState();
}

class _InitUIState extends State<InitUI> {
  final key = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: key,
      pages: [
        PageViewModel(
            title: "Quản lý giờ giấc",
            body: "Những mục tiêu, những sự kiện sẽ không bị bỏ lỡ nữa."),
        PageViewModel(
            title: "Học tập", body: "Theo dõi tiến trình, thành tích của các học phần của bạn."),
        PageViewModel(
            title: "Chia sẻ học liệu",
            body: "Cùng đăng tải và chia sẻ những kiến thức với các người dùng khác."),
        PageViewModel(title: "Hết rồi!", body: "Bắt đầu hành trình cùng FLNStudyAssisant thôi!"),
      ],
      showSkipButton: true,
      skip: const Text("Bỏ qua"),
      next: const Text("Tiếp"),
      done: const Text("Bắt đầu"),
      onDone: () => Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false)
          .then((value) => storage.write(key: "first", value: "/login")),
    );
  }
}
