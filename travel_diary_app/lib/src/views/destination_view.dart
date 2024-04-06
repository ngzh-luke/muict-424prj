import 'package:flutter/material.dart';

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
        title: Text('Details: $title'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Handle action, e.g., navigate to home
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomeView()),
                // );
              },
            ),
          ),
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About Destination',
                      style: TextStyle(
                          fontSize: 20,
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
}
