// Kittipich Aiumbhornsin
// Section 3 #6488004
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/profile.png'),
                  height: 100,
                ),
                const Text('Login',
                    style: TextStyle(fontSize: 20, color: Colors.blue)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: const {'username': '', 'password': ''},
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'username',
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'please insert email'),
                            FormBuilderValidators.email(),
                          ]),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'password',
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'please insert password'),
                            FormBuilderValidators.minLength(
                              8,
                              errorText: 'min length 8 character',
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: MaterialButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                // open Homepage ( pass launcher )
                                Navigator.pushNamed(context, '/launcher');
                              } else {
                                print(" validation failed ");
                              }
                            },
                            child: const Text("Login",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            child: MaterialButton(
                          onPressed: () {
                            // open register
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Register User',
                              style: TextStyle(color: Colors.blue)),
                        )),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            child: MaterialButton(
                          onPressed: () {
                            // open home
                            Navigator.pushNamed(context, '/home');
                          },
                          child: const Text('Back Home',
                              style: TextStyle(color: Colors.red)),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
