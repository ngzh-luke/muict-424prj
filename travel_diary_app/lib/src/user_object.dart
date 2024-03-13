import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserObject {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final emailContr = TextEditingController();
  final nameContr = TextEditingController();
  final passwordContr = TextEditingController();
  final nk = GlobalKey<NavigatorState>();

  showErrorDialog(BuildContext context, String errMsg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        // Navigator.pushNamed(context, '/signup');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Encountered error!"),
      content: Text(errMsg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> authSignUp(context) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   barrierDismissible: true,
    //   barrierLabel: 'Loading',
    // );
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailContr.text.trim(), password: passwordContr.text.trim());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      showErrorDialog(context, e.message.toString());
    }

    nk.currentState!.popUntil(((route) => route.isFirst)); //
    // nk.currentState!.popUntil((route) => false);
  }

  Future<void> authSignIn(context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: true,
      barrierLabel: 'Loading',
    );
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailContr.text.trim(), password: passwordContr.text.trim());
    } on FirebaseAuthException catch (e) {
      showErrorDialog(context, e.message.toString());
      log(e.toString());
      // navigatorKey.currentState!.popUntil(ModalRoute.withName('/login'));
      // navigatorKey.currentState!.popUntil(((route) => false));
    }
    // Navigator.of(context)
    //     .pop([ModalRoute.withName('/login'), ModalRoute.withName('/home')]);

    // nk.currentState!.popUntil((route) => false); //
    // navigatorKey.currentState!.popUntil(((route) => route.isFirst));
  }

  Future authSignOut(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        _firebaseAuth.signOut();
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Signout?"),
      content: const Text("Would you like signout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getCurrentUser() {
    return UserObject().currentUser;
  }

  getUserUID() => currentUser?.uid;
}
