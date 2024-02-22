// Kittipich Aiumbhornsin
// Section 3 #6488004
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('HomePage'),
              const Spacer(),
              SizedBox(
                  child: MaterialButton(
                onPressed: () {
// open Homepage
                  Navigator.pushNamed(context, '/about');
                },
                child:
                    const Text('About', style: TextStyle(color: Colors.blue)),
              )),
              const Spacer()
            ],
          ),
        ));
  }
}
