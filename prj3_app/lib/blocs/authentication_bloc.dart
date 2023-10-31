import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prj3_app/main.dart';
import 'package:prj3_app/services/apis/api.dart';

part "authentication_bloc.freezed.dart";

enum AuthState { unauthenticated, authenticated, authenticating }

abstract class AuthenticationEvent {}

class AuthenticationRegister extends AuthenticationEvent {
  final String email, password;
  AuthenticationRegister({required this.email, required this.password});
}

class AuthenticationLogin extends AuthenticationEvent {
  final String email, password;
  AuthenticationLogin({required this.email, required this.password});
}

class _AuthenticationInit extends AuthenticationEvent {}

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState({@Default(AuthState.unauthenticated) AuthState state}) =
      _AuthenticationState;
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<_AuthenticationInit>((event, emit) async {
      await storage.read(key: "token").then((value) {
        print("token $value");
        if (value != null) {
          emit(state.copyWith(state: AuthState.authenticated));
        }
      });
    });
    on<AuthenticationRegister>((event, emit) async {
      var response = await Api().register(email: event.email, password: event.password);
      Fluttertoast.showToast(msg: response.toString());
    });
    on<AuthenticationLogin>((event, emit) async {
      emit(state.copyWith(state: AuthState.authenticating));
      var response = await Api().login(email: event.email, password: event.password);
      Fluttertoast.showToast(msg: response.toString());
      if (response["code"].toString().contains("200")) {
        await storage.write(key: "token", value: response["data"]["token"]);
        emit(state.copyWith(state: AuthState.authenticated));
      } else {
        emit(state.copyWith(state: AuthState.unauthenticated));
      }
    });
    add(_AuthenticationInit());
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);
    if (change.currentState.state == AuthState.authenticated &&
        change.nextState.state == AuthState.unauthenticated) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil("/login", (route) => false);
    } else if (change.nextState.state == AuthState.authenticated &&
        change.currentState.state != AuthState.authenticated) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }
}
