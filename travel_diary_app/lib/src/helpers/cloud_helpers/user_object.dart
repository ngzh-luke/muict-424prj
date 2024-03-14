import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../dialoger.dart' as d;

class UserObject {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // final nk = GlobalKey<NavigatorState>();

  Future<void> authSignUp(
      {required context,
      required String email,
      required String password}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: true,
      barrierLabel: 'Loading',
    );
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (fbe) {
      Navigator.of(context, rootNavigator: true).pop();
      log(fbe.message.toString());
      // Navigator.of(context, rootNavigator: true).pop();
      Future.delayed(Duration.zero);
      d.showErrDialog(context, fbe.message.toString());
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      log(e.toString());
      // Navigator.of(context, rootNavigator: true).pop();
      Future.delayed(Duration.zero);
      d.showErrDialog(context, e.toString());
    } finally {
      // if account is created successfully
      if (!_firebaseAuth.currentUser!.isAnonymous) {
        // https://stackoverflow.com/questions/59385404/navigator-pop-wont-close-the-simpledialog-in-flutter
        Navigator.of(context, rootNavigator: true).pop();
        d.showSuccessDialog(context, 'Your account has been created',
            'Account created', null, true);
      } else {}
    }
  }

  Future<void> authSignIn(
      {required context,
      required String email,
      required String password}) async {
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
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (fbe) {
      Navigator.of(context, rootNavigator: true).pop();
      log(fbe.message.toString());
      Future.delayed(Duration.zero);
      d.showErrDialog(context, fbe.message.toString());
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      log(e.toString());
      Future.delayed(Duration.zero);
      d.showErrDialog(context, e.toString());
    } finally {
      // if log in successfully
      if (!_firebaseAuth.currentUser!.isAnonymous) {
        // https://stackoverflow.com/questions/59385404/navigator-pop-wont-close-the-simpledialog-in-flutter
        Navigator.of(context, rootNavigator: true)
            .pop(); // pop indicator out when loading is complete
      } else {}
    }
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
