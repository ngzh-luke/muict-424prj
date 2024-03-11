import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/home_page/add_destination.dart';
import 'package:travel_diary_app_/src/home_page/calenda_view.dart';
import 'destination_view.dart';

class HomeView extends StatelessWidget {
  // const HomeView({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.indigo[200],
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ),
        title: const Text("Travel Diary app by Good Boys Team"),
        actions: [
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              // Handle action (e.g., open a map)
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Hello and welcome back, ${user.email}!\nExplore the Beautiful World',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Your Destination',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 250, // Adjust the height to fit the card
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations
                    .length, // Assuming 'destinations' is a list of your destinations
                itemBuilder: (BuildContext context, int index) {
                  final destination = destinations[index];
                  return DestinationCard(
                    title: destination.title,
                    location: destination.location,
                    date: destination.date,
                    imageUrl: destination.imageUrl,
                    latitude: destination.latitude, // Pass the actual latitude
                    longitude:
                        destination.longitude, // Pass the actual longitude
                    description:
                        destination.description, // Pass the actual description
                  );
                },
              ),
            ),
            // Other widgets and content would follow
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
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
              MaterialPageRoute(
                  builder: (context) => const AddDestinationView()),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailsView(
              title: " title",
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
    );
  }
}

// Assuming you have a list of destinations like this
final List<Destination> destinations = [
  Destination(
    title: 'Chilling in Thailand',
    location: 'Ao Nang, Krabi',
    date: '14/02',
    imageUrl:
        'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
    latitude: 8.041492,
    longitude: 98.8369438,
    description: 'Description of Chilling in Thailand',
  ),
  Destination(
    title: 'Chilling in Thailand',
    location: 'Ao Nang, Krabi',
    date: '14/02',
    imageUrl:
        'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
    latitude: 8.041492,
    longitude: 98.8369438,
    description: 'Description of Chilling in Thailand',
  ),
  Destination(
    title: 'Chilling in Thailand',
    location: 'Ao Nang, Krabi',
    date: '14/02',
    imageUrl:
        'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
    latitude: 8.041492,
    longitude: 98.8369438,
    description: 'Description of Chilling in Thailand',
  ),
  Destination(
    title: 'Chilling in Thailand',
    location: 'Ao Nang, Krabi',
    date: '14/02',
    imageUrl:
        'https://a.cdn-hotels.com/gdcs/production25/d278/9609fe78-1dd2-47bf-b75d-15df7f6feb8f.jpg',
    latitude: 8.041492,
    longitude: 98.8369438,
    description: 'Description of Chilling in Thailand',
  ),
  // Add more destinations
];

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
