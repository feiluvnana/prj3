import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj3_app/blocs/authentication_bloc.dart';
import 'package:prj3_app/helpers/styling.dart';

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
                          decoration: flnInputDecoration(themeData).copyWith(labelText: "Email"),
                        ),
                      ),
                      TextFormField(
                        controller: password,
                        decoration: flnInputDecoration(themeData).copyWith(
                            labelText: "Mật khẩu", suffixIcon: const Icon(Icons.visibility)),
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: themeData.primaryColor,
                              foregroundColor: themeData.canvasColor,
                              padding: const EdgeInsets.all(10),
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            fkey.currentState?.validate();
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                AuthenticationLogin(email: email.text, password: password.text));
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: const Center(
                              child: Text("Đăng nhập"),
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
