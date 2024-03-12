import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/authentication/authen.dart';
import 'package:travel_diary_app_/src/home_page/home_view.dart';

class AuthLogic extends StatefulWidget {
  const AuthLogic({super.key});
  static const routeName = '/auth-logic';

  @override
  State<AuthLogic> createState() => _AuthLogicState();
}

class _AuthLogicState extends State<AuthLogic> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
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
            return HomeView();
          } else {
            //  if not login, return login page, else return signup page
            return const Authen();
          }
        });
  }
}
