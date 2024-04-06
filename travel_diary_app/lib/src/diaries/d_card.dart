import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/views/destination_view.dart';
// import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DestinationCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String imageStoragePath;
  final double latitude;
  final double longitude;
  final String description;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DestinationCard({
    Key? key,
    required this.title,
    required this.location,
    required this.date,
    required this.imageStoragePath,
    required this.latitude,
    required this.longitude,
    required this.description,
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
                builder: (context) => DestinationDetailsView(
                  title: title,
                  location: location,
                  description: description,
                  imageUrl: imageStoragePath, // Pass the storage path
                  date: date,
                  latitude: latitude,
                  longitude: longitude,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 222,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: (imageStoragePath == '')
                        ? Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.scaleDown,
                          )
                        : Image.network(
                            imageStoragePath,
                            fit: BoxFit.cover,
                          ),
                  ),
                  ListTile(
                    title: Text(title),
                    subtitle: Text('$location · $date'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    firebase_storage.Reference ref = storage.ref().child(imagePath);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}
