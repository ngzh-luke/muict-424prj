import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_diary_app/src/helpers/diary.dart';

final collection = FirebaseFirestore.instance.collection('postBuckets');

Stream<QuerySnapshot> get collectionStream =>
    FirebaseFirestore.instance.collection('postBuckets').snapshots();

List<String> toFirestore() {
  List temp = 
  {
   if (Diary.title != null) "title": Diary.title;
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
      }
  return temp;
}

List<String> getPostID(String userID) {
  final data = collection.where({userID: userID}).get();

  final ref = collection.doc().withConverter(
        fromFirestore: Diary.fromFirestore,
        toFirestore: (Diary diary, _) => diary.toFirestore(),
      );
}
