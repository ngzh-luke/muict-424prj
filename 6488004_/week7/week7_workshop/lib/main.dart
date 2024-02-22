import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import pages
import 'package:workshop/pages/about.dart';
import 'package:workshop/pages/home.dart';
// import 'package:workshop/pages/editProfile.dart';
import 'package:workshop/pages/login.dart';
// import 'package:workshop/pages/register.dart';
// import 'package:workshop/pages/launcher.dart';
// import 'package:workshop/pages/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    const String title = 'Flutter workshop';
    return MaterialApp(
      title: title,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        // "/register": (context) => RegisterPage(),
        // "/profile": (context) => ProfilePage(),
        // "/editprofile": (context) => EditProfilePage(),
        // "/launcher": (context) => Launcher(),
        "/about": (context) {
          return AboutPage();
        }
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: HomePage(),
    );
  }
}
