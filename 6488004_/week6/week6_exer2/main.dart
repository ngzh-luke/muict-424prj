// Kittipich Aiumbhornsin
// Section 3 #6488004
//
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   // TODO 1: HTTP GET Here.
//   final response =
//       await http.get(Uri.https('jsonplaceholder.typicode.com', '/albums/4'));
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response, // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response, // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,  then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response, // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;
  const Album({
    required this.id,
    required this.title,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
      } =>
        Album(
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };

    // return Album(
    //   userId: json['userId'],
    //   id: json['id'],
    //   title: json['title'],
    // );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  String txt = '';

  @override
  void initState() {
    // TODO 2: Refetch outside build()
    super.initState();
    futureAlbum = Future<Album>(() => Album(id: 0, title: ''));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kittipich 6488004',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Post data #6488004'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const Text(
                  "1. type in the desire text\n2. press enter\n3. click create data button and see the result"),
              TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(hintText: "Enter title"),
                onSubmitted: (value) => setState(() {
                  txt = value;
                }),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      futureAlbum = createAlbum(txt);
                    });
                  },
                  child: const Text("Create data")),
              FutureBuilder<Album>(
                  //TODO 3: Asynchronous Builder for Flutter Future
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }),
            ])),
      ),
    );
  }
}
