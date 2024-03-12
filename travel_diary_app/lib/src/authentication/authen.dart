import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/authentication/login_view.dart';
import 'package:travel_diary_app_/src/authentication/signup_view.dart';
import 'package:travel_diary_app_/src/home_page/home_view.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final navigatorKey = GlobalKey<NavigatorState>();
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginView(
          onClickLogIn: toggle,
        )
      : SignupView(onClickSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
