// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:travel_diary_app_/src/authentication/auth_logic.dart';
import 'package:travel_diary_app_/src/user_object.dart';
import 'signup_view.dart';
import 'forgot_password_view.dart';
// import '../home_page/home_view.dart';

class LoginView extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginView({Key? key, required this.onClickLogIn}) : super(key: key);
  static const routeName = '/login';
  final VoidCallback onClickLogIn;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailContr = TextEditingController();
  final nameContr = TextEditingController();
  final passwordContr = TextEditingController();
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    emailContr.dispose();
    passwordContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return signInUI(context);
  }

  Scaffold signInUI(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign in now',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Please sign in to continue our app',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: emailContr,
              decoration: InputDecoration(
                hintText: 'user@email.com',
                hintStyle: TextStyle(color: Colors.red[200]),
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.red),
                floatingLabelStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  backgroundColor: Colors.grey[200],
                ),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: passwordContr,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.red[200]),
                hintText: '********',
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.red),
                floatingLabelStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  backgroundColor: Colors.grey[200],
                ),
                floatingLabelAlignment: FloatingLabelAlignment.center,
                suffixIcon: const Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordView()),
                  );
                  // Implement forgot password functionality
                },
                child: const Text('Forget Password?'),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => UserObject().authSignIn(
                  context: context,
                  email: emailContr.text,
                  password: passwordContr.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity,
                    50), // double.infinity is the width and 50 is the height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            // ignore: prefer_const_constructors
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupView(
                            onClickSignUp: () => true,
                          )),
                );
              },
              child: RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickLogIn,
                  children: const <TextSpan>[
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 170, 170))),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showErrorDialog(BuildContext context, String errMsg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        // Navigator.pushNamed(context, '/login');
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
}
