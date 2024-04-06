import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/diaries/all_diaries.dart';
import 'package:travel_diary_app/src/diaries/my_diaries.dart';
import 'package:travel_diary_app/src/diaries/add_destination.dart';
import 'package:travel_diary_app/src/views/calenda_view.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final user = UserObject().currentUser;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: leftDrawer(context),
      appBar: headBar(),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            // Assuming the add button is at index 1
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddDestinationView()),
            );
          } else if (index == 2) {
            // Handle calendar tap
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarView()),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Hello and welcome back, ${user?.email}!',
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Explore the Beautiful World",
              style: TextStyle(color: Colors.cyan, fontSize: 26),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Your Destinations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 4.0, top: 5.0, bottom: 8.0),
            child: SizedBox(
              height: 200, //
              child: MyDiariesRender(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Explore from other peoples' destinations",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0, bottom: 8.0),
            child: SizedBox(
              height: 200,
              child: AllDiariesRender(),
            ),
          ),
          const Gap(1),

          // Other widgets and content would follow
        ],
      ),
    );
  }

  AppBar headBar() {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.indigo[200],
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          // open left drawer after click on profile icon
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      title: const Text("Travel Diary"),
      actions: [
        IconButton(
          icon: const Icon(Icons.public),
          onPressed: () {
            // Handle action (e.g., open a map)
          },
        ),
      ],
      backgroundColor: Colors.orange,
      elevation: 0,
    );
  }

  Drawer leftDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(1),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Good Boys'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: const Text("Setting"),
              onTap: () => Navigator.of(context).pushNamed('/settings')),
          ListTile(
              textColor: Colors.red,
              onTap: () => UserObject().authSignOut(context),
              title: const Text("Signout")),
        ],
      ),
    );
  }
}
