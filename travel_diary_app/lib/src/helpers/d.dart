import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Diary {
  final String userID;
  final String title;
  final String? content;
  final GeoPoint? location;
  final DateTime? when;
  final DateTime updatedTS;
  final Reference? attachment;

  Diary(
    this.userID,
    this.title,
    this.updatedTS, {
    this.content,
    this.location,
    this.when,
    this.attachment,
  });

  List getStructure() {
    return [userID, title, content, location, when, updatedTS, attachment];
  }

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "title": title,
        "content": content,
        "location": location,
        "when": when,
        "updatedTS": updatedTS,
        "attachment": attachment
      };

  Diary.fromSnapshot(snapshot)
      : userID = snapshot.data()['userID'],
        title = snapshot.data()['title'],
        content = snapshot.data()['content'],
        location = snapshot.data()['location'],
        when = snapshot.data()['when'].toDate(),
        updatedTS = snapshot.data()['updatedTS'].toDate(),
        attachment = snapshot.data()['attachment'];
}
