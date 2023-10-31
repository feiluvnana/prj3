import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj3_app/blocs/authentication_bloc.dart';
import 'package:prj3_app/helpers/styling.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  final fkey = GlobalKey<FormState>();

  final email = TextEditingController();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Đăng ký và bắt đầu học thôi nào!",
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          controller: password,
                          decoration: flnInputDecoration(themeData).copyWith(
                              labelText: "Mật khẩu", suffixIcon: const Icon(Icons.visibility)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          decoration: flnInputDecoration(themeData).copyWith(
                              labelText: "Xác nhận mật khẩu",
                              suffixIcon: const Icon(Icons.visibility)),
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
                                AuthenticationRegister(email: email.text, password: password.text));
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: const Center(
                              child: Text("Đăng ký"),
                            ),
                          )),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Đã có tài khoản? "),
                  TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Đăng nhập ngay")),
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
