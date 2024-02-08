// Kittipich Aiumbhornsin
// section 3 #6488004
// Good Boys group
import 'package:flutter/material.dart';
import 'package:route_hw/have_been_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Boys Travel Diary',
      initialRoute: '/',
      routes: {
        '/': (context) {
          return const LandingPage();
        }
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: const Text("This is a landing page"),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text("See where you have been"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BeenPage(title: "Have been page")));
        },
      )),
    );
  }
}
