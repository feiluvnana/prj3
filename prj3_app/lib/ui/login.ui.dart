import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj3_app/blocs/student.bloc.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final fkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Chào mừng bạn tới với FLNStudyAssistant!",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              Form(
                  key: fkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration(labelText: "Email"),
                        ),
                      ),
                      TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                            labelText: "Mật khẩu", suffixIcon: Icon(Icons.visibility)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Quên mật khẩu"),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: BlocProvider.of<StudentBloc>(context, listen: true)
                                  .state
                                  .authenticating
                              ? null
                              : () {
                                  fkey.currentState?.validate();
                                  BlocProvider.of<StudentBloc>(context).add(
                                      StudentLogin(email: email.text, password: password.text));
                                },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Center(
                              child: BlocProvider.of<StudentBloc>(context, listen: true)
                                      .state
                                      .authenticating
                                  ? const CupertinoActivityIndicator()
                                  : const Text("Đăng nhập"),
                            ),
                          )),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản? "),
                  TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text("Đăng ký ngay")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
