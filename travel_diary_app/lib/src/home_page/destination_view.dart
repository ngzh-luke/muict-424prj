import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/home_page/map_view.dart';

class DestinationDetailsView extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final String imageUrl;
  final String date; // Assuming you might want to use the date somewhere
  final double latitude;
  final double longitude;

  const DestinationDetailsView({
    Key? key,
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
        title: Text('Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.black),
            onPressed: () {
              // Handle action, e.g., navigate to home
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl,
            height: 250,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'About Destination',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  child: Text(
                    'Read More',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onTap: () {
                    // Handle read more tap
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle see maps tap
                      // Router to map view with send latlng
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            title: title,
                            latitude: latitude,
                            longitude: longitude,
                          ),
                        ),
                      );


                    },
                    child: Text('See maps'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
