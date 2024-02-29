import 'package:flutter/material.dart';

class AddDestinationView extends StatelessWidget {
  const AddDestinationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Handle save action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Handle import photo
              },
              child: Container(
                height: 200, // Set the image container height
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.camera_alt, // Placeholder icon
                  color: Colors.grey[600],
                ),
                alignment: Alignment.center,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Heading',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () {
                // Handle date selection
              },
            ),
          ],
        ),
      ),
    );
  }
}
