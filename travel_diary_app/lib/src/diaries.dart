import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;
import 'package:travel_diary_app/src/helpers/dialoger.dart';
import 'package:travel_diary_app/src/home_page/home_view.dart';

class DiariesRender extends StatefulWidget {
  const DiariesRender({super.key});
  static const routeName = '/diaries';

  @override
  State<DiariesRender> createState() => _DiariesRenderState();
}

class _DiariesRenderState extends State<DiariesRender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: p.collectionStream,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              showErrDialog(context, snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return renderDiaries(p.collection, snapshot);
            } else {
              Navigator.of(context).pop();
            }
            return const Center();
          },
        ),
      ),
    );
  }

  renderDiaries(CollectionReference d, AsyncSnapshot<dynamic> snapshot) {
    // FutureBuilder<DocumentSnapshot>(future: ,)
    final diaries = d.doc().get();
    final amount = diaries.then((value) => null);
    print('$diaries $amount');
    return
        // SafeArea(
        //     child: ListView(
        //         // children: d.doc() {
        //         //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //         //   return ListTile(
        //         //     title: Text(data['title']),
        //         //     subtitle: Text(data['content']),
        //         //   );
        //         // }).toList(),
        //         ));
        //
        SafeArea(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: SizedBox(
            height: double.maxFinite, // Adjust the height to fit the card
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
                  longitude: destination.longitude, // Pass the actual longitude
                  description:
                      destination.description, // Pass the actual description
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
