import 'dart:developer';
import 'package:travel_diary_app/src/authentication/login_view.dart';
import 'package:travel_diary_app/src/authentication/signup_view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/home_page/home_view.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';

class AuthLogic extends StatefulWidget {
  const AuthLogic({super.key});
  static const routeName = '/auth-logic';

  @override
  State<AuthLogic> createState() => _AuthLogicState();
}

class _AuthLogicState extends State<AuthLogic> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: FirebaseAuth.instance.authStateChanges(),
        stream: UserObject().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something has went wrong, please try again later'),
            );
          } else if (snapshot.hasData) {
            // if given credentials are all match to auth server, return home page to user
            log('home view');
            return HomeView();
          } else {
            //  if not login, return login page, else return signup page
            log('authen');
            return const Authen();
          }
        });
  }
}

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
        log('islog:${isLogin}');
      });
}
