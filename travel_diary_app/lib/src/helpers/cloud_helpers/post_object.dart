import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_diary_app/src/helpers/diary.dart';

final collection = FirebaseFirestore.instance.collection('postBuckets');

Stream<QuerySnapshot> get collectionStream =>
    FirebaseFirestore.instance.collection('postBuckets').snapshots();

List<String> getPostsID(String userID) {
  final data = collection
      .where('userID', isEqualTo: userID)
      .get()
      .then((value) => (querySnapshot) {
            print("Successfully completed");
            for (var docSnapshot in querySnapshot.docs) {
              print('${docSnapshot.id} => ${docSnapshot.data()}');
            }
          });
  return [data.toString()];
}
