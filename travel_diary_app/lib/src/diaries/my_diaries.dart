import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/diaries/d_card.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:travel_diary_app/src/helpers/dialoger.dart';
import 'package:intl/intl.dart';

class MyDiariesRender extends StatefulWidget {
  MyDiariesRender({super.key});
  static const routeName = '/diaries';

  @override
  State<MyDiariesRender> createState() => _MyDiariesRenderState();
}

class _MyDiariesRenderState extends State<MyDiariesRender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Widget>(
            future: stream(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                showErrDialog(context, snapshot.error.toString());
                return const Text('Error');
              } else {
                return snapshot.data!;
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Widget> stream() async {
    return StreamBuilder<QuerySnapshot>(
      stream: p.collection.orderBy('updatedTS', descending: true).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          showErrDialog(context, snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return renderMyDiaries(p.collection, snapshot);
        } else {
          Navigator.of(context).pop();
        }
        return const Center();
      },
    );
  }

  Widget renderMyDiaries(
      CollectionReference d, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final userId = UserObject().getUserUID();
      final diaries = snapshot.data!.docs
          .where((doc) => doc.get('userID') == userId)
          .toList();
      // print(diaries.length.toString());
      if (diaries.isEmpty) {
        return const Center(child: Text('No data available'));
      }
      return ListView.builder(
        itemCount: diaries.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final diary = diaries[index].data() as Map<String, dynamic>;
          final dateTime =
              diary['when'] != null ? diary['when'].toDate() : null;
          return DestinationCard(
            userID: userId,
            id: diaries[index].id,
            title: diary['title'] ?? 'No Title',
            location: diary['location'] ?? 'No Location',
            date: diary['when'] != null
                ? DateFormat('yyyy.MM.dd').format(dateTime)
                : 'No Date',
            dateT: diary['when'] != null
                ? diary['when'].toDate().toString()
                : 'No Date',
            imageStoragePath: diary['attachment'] ?? '',
            latitude: diary['latitude'] ?? 0.0,
            longitude: diary['longitude'] ?? 0.0,
            description: diary['content'] ?? 'No Description',
          );
        },
      );
    } else {
      return const Center(child: Text('No data available, try add one!'));
    }
  }
}
