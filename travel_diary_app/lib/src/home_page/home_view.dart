import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/diaries/all_diaries.dart';
import 'package:travel_diary_app/src/diaries/my_diaries.dart';
import 'package:travel_diary_app/src/home_page/add_destination.dart';
import 'package:travel_diary_app/src/home_page/calenda_view.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;
import 'destination_view.dart';

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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello and welcome back, ${user?.email}!',
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Explore the Beautiful World",
              style: TextStyle(color: Colors.cyan, fontSize: 26),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                left: 8.0, right: 4.0, top: 16.0, bottom: 16.0),
            child: SizedBox(
              height: 160, //
              child: MyDiariesRender(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(14),
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
              height: 160, //
              child: AllDiariesRender(),
            ),
          )

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

class DestinationCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String description; // Add a description field

  const DestinationCard({
    Key? key,
    required this.title,
    required this.location,
    required this.date,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.description, // Make it required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // StreamBuilder<QuerySnapshot>(
                    //     stream: snapshotsStream, builder: (context, snapshot){})
                    DestinationDetailsView(
                  title: "this is",
                  location: "location",
                  description:
                      "This is description", // Pass the actual description to the details view
                  imageUrl:
                      "https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg",
                  date: '14/02',
                  latitude: 8.041492, // Replace with the actual latitude
                  longitude: 98.8369438, // Replace with the actual longitude
                ),
              ),
            );
          },
          child: Container(
            width: 200, // Adjust the width to fit the card
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 140,
                  ), // Adjust the height to fit the image
                  ListTile(
                    title: Text(title),
                    subtitle: Text('$location · $date'),
                  ),
                ],
              ),
            ),
          ),
        ),
        // ElevatedButton(
        //     onPressed: () => Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => DiariesRender())),
        //     child: const Text("to diaries"))
        // ElevatedButton(
        //     onPressed: () => showGenDialog(
        //         context,
        //         StorageObject().getRefOfObject('calendasr.jpg').toString(),
        //         'ref'),
        //     child: null)
      ],
    );
  }
}

// Assuming you have a list of destinations like this
// final List<Destination> destinations = [
//   Destination(
//     title: 'Chilling in Thailand',
//     location: 'Ao Nang, Krabi',
//     date: '14/02',
//     imageUrl:
//         'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
//     latitude: 8.041492,
//     longitude: 98.8369438,
//     description: 'Description of Chilling in Thailand',
//   ),
//   Destination(
//     title: 'Chilling in Thailand',
//     location: 'Ao Nang, Krabi',
//     date: '14/02',
//     imageUrl:
//         'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
//     latitude: 8.041492,
//     longitude: 98.8369438,
//     description: 'Description of Chilling in Thailand',
//   ),
//   // Destination(
//   //   title: 'Chilling in Thailand',
//   //   location: 'Ao Nang, Krabi',
//   //   date: '14/02',
//   //   imageUrl:
//   //       'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
//   //   latitude: 8.041492,
//   //   longitude: 98.8369438,
//   //   description: 'Description of Chilling in Thailand',
//   // ),
//   // Add more destinations
// ];

class Destination {
  final String title;
  final String location;
  final String date;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String description; // Add a description field

  Destination({
    required this.title,
    required this.location,
    required this.date,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.description, // Make it required
  });
}
