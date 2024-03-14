import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app_/src/dialoger.dart';

class AddDestinationView extends StatelessWidget {
  AddDestinationView({super.key});

  final titleCont = TextEditingController();
  final descCont = TextEditingController();
  final headingCont = TextEditingController();
  var savedDate;
  final collection = FirebaseFirestore.instance.collection('postBuckets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Handle save action

              try {
                collection.add({
                  'title': headingCont.text.trim(),
                  'content': descCont.text.trim()
                }).whenComplete(() => showSuccessDialog(
                    context, 'Trip has been added', 'Added!', null, true));
              } catch (e) {
                showErrDialog(context,
                    'Unknown error occured when adding new trip, please try again later');
                log(e.toString());
              } finally {}
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              controller: headingCont,
              decoration: const InputDecoration(
                labelText: 'Heading',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            TextFormField(
              controller: descCont,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            InputDatePickerFormField(
              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: DateTime.now(),
              onDateSaved: (value) => savedDate = value,
            ),
          ],
        ),
      ),
    );
  }
}
