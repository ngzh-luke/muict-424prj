import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart';

class Diary {
  final String userID; 
  final String title;
  final String? content;
  final GeoPoint? location;
  final DateTime? when;
  final DateTime updatedTS;
  final Reference? attachment;

  Diary(this.userID, this.title, this.updatedTS, {
    this.content,
    this.location,
    this.when,
    this.attachment,
  });

  List getStructure(){
    return [userID,title,content,location,when,updatedTS,attachment];
  }


  factory Diary.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Diary(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
          data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }




  final ref = p.collection.doc("LA").withConverter(
      fromFirestore: Diary.fromFirestore,
      toFirestore: (Diary diary, _) => diary.toFirestore(),
    );
  final docSnap = await ref.get();
final city = docSnap.data(); // Convert to City object
if (city != null) {
  print(city);
} else {
  print("No such document.");
}
}