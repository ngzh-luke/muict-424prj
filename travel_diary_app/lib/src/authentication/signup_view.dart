import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/authentication/auth_logic.dart';
import 'package:travel_diary_app_/src/user_object.dart';

class SignupView extends StatefulWidget {
  // ignore: use_super_parameters
  const SignupView({Key? key, required this.onClickSignUp}) : super(key: key);

  final VoidCallback onClickSignUp;
  // late VoidCallback nk;
  static const routeName = '/signup';

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  // _SignupViewState(nk);

  final emailContr = TextEditingController();
  final nameContr = TextEditingController();
  final passwordContr = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return signUpUI(context);
  }

  Scaffold signUpUI(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Sign up now')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign up now",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Please fill the details and create account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: nameContr,
              decoration: InputDecoration(
                hintText: 'NTP Life',
                hintStyle: const TextStyle(color: Colors.red),
                labelText: 'Full Name',
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
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: const TextStyle(color: Colors.red),
              controller: emailContr,
              decoration: InputDecoration(
                hintText: 'user@email.com',
                hintStyle: const TextStyle(color: Colors.red),
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
                hintText: '********',
                hintStyle: const TextStyle(color: Colors.red),
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
              alignment: Alignment.centerLeft,
              child: Text(
                'Password must be at least 6 characters long',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your signup logic
                UserObject().authSignUp(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity,
                    50), // double.infinity is the width and 50 is the height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    // Text('Already have an account? Sign in'),
                    RichText(
                  // ignore: prefer_const_constructors
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickSignUp,
                    text: 'Already have an account? ',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 71, 170, 170)),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
