import 'dart:developer';
// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../dialoger.dart' as d;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageObject {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref('/');

  Map<String, Reference> objectRef = {};

  void createObjRef({required String objectName}) {
    final newRef = storageRef.child(objectName);
    final newEntry = <String, Reference>{objectName: newRef};

    objectRef.addAll(newEntry);
  }

  getRefOfObject({required String objectName}) {
    if (objectRef.containsKey(objectName)) {
      return objectRef[objectName];
    }
    return null;
  }

  uploadFileObj(
      {required String objectName, required BuildContext context}) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/";
    final file = File(filePath);

    // create and get obj ref
    createObjRef(objectName: objectName);
    final ref = getRefOfObject(objectName: objectName);

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image");

    // Upload file and metadata to the path
    final uploadTask = ref.putFile(file, metadata);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          log("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          log("Upload is paused.");
          d.showActionDialog(context, 'Upload is paused, continue upload?',
              actionName: 'Continue',
              action: () async => await uploadTask.resume());
          log('resumed upload');

          break;
        case TaskState.canceled:
          log("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          d.showErrDialog(
              context, "Can't upload the file:${file.absolute.toString()}");
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          d.showSuccessDialog(
              context,
              'The selected file is upload successfully',
              'Upload completed',
              null,
              false);
          break;
      }
    });
  }

  delFileObject(
      {required String objectName, required BuildContext context}) async {
    if (getRefOfObject(objectName: objectName) != null) {
      createObjRef(objectName: objectName);
      final ref = getRefOfObject(objectName: objectName);
      d.showActionDialog(context, "This action can't be undone!",
          title: 'Are you sure to delete?',
          actionName: 'Yes, delete it!',
          action: await ref.delete());
    }
  }

  getFileObject(String objectName) async {
    // create and get obj ref
    createObjRef(objectName: objectName);
    final ref = getRefOfObject(objectName: objectName);

    final result = await ref.list();
    return result;
  }
}
