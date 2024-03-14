// import 'dart:developer';
// import 'package:flutter/material.dart';
// import '../dialoger.dart' as d;
import 'package:firebase_storage/firebase_storage.dart';

class StorageObject {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref('/');

  Map<String, Reference> objectRef = {};

  void createObjRef(String objectName) {
    final newRef = storageRef.child(objectName);
    final newEntry = <String, Reference>{objectName: newRef};

    objectRef.addAll(newEntry);
  }

  getRefOfObject(String objectName) {
    if (objectRef.containsKey(objectName)) {
      return objectRef[objectName];
    }
  }
}
