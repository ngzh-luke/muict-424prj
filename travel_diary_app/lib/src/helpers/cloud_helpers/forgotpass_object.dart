import 'package:cloud_firestore/cloud_firestore.dart';

final collection = FirebaseFirestore.instance.collection('resetPassRequests');

Stream<QuerySnapshot?> get collectionStream =>
    FirebaseFirestore.instance.collection('resetPassRequests').snapshots();
