import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/diaries/edit_d.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';

class DestinationDetailsView extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final String imageUrl;
  final String date;
  final String userID;
  final double latitude;
  final double longitude;
  final String id;

  const DestinationDetailsView({
    Key? key,
    required this.id,
    required this.userID,
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details: $title'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          editIcon(context),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
                child: imageUrl == ''
                    ? Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Where: $location",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "When: $date",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'About $title',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    // InkWell(
                    //   child: Text(
                    //     'Read More',
                    //     style: TextStyle(fontSize: 16, color: Colors.blue),
                    //   ),
                    //   onTap: () {
                    //     // Handle read more tap
                    //   },
                    // ),
                    const SizedBox(height: 16),
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // Handle see maps tap
                    //       // Router to map view with send latlng
                    //       // Navigator.push(
                    //       //   context,
                    //       //   MaterialPageRoute(
                    //       //     builder: (context) => MapScreen(
                    //       //       title: title,
                    //       //       latitude: latitude,
                    //       //       longitude: longitude,
                    //       //     ),
                    //       //   ),
                    //       // );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.blue,
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 32, vertical: 16),
                    //     ),
                    //     child: const Text('See maps'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editIcon(BuildContext context) {
    if (UserObject().getUserUID().toString() == userID) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            // Handle action, navigate to edit
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditDestinationView(
                        id: id,
                        title: title,
                        location: location,
                        description: description,
                        imageUrl: imageUrl,
                        dateTime: DateTime.parse(date),
                      )),
            );
          },
        ),
      );
    } else {
      return const Center();
    }
  }
}
