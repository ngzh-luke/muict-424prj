import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:travel_diary_app/src/helpers/dialoger.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_diary_app/src/views/home_view.dart';

class EditDestinationView extends StatefulWidget {
  final String title;
  final String location;
  final String description;
  final String imageUrl;
  final DateTime dateTime;
  final String id;

  EditDestinationView({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.dateTime,
  });

  @override
  State<EditDestinationView> createState() => _EditDestinationViewState();
}

class _EditDestinationViewState extends State<EditDestinationView> {
  final topicCont = TextEditingController();
  final descCont = TextEditingController();
  final locaCont = TextEditingController();
  File? _image;
  String? imgLink;

  late DateTime savedDateTime; // Declare the variable without initializing

  @override
  void initState() {
    super.initState();
    imgLink = widget.imageUrl;
    savedDateTime = widget.dateTime; // Initialize in initState()
  }

  @override
  void dispose() {
    topicCont.dispose();
    descCont.dispose();
    locaCont.dispose();
    super.dispose();
  }

  final collection = p.collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Trip"),
        actions: [
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(context);
            },
          ),
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_errorText(topicCont, 3, v: topicCont.text) == null) {
                try {
                  final userID = UserObject().getUserUID();
                  final docID = widget.id;
                  if (docID.isNotEmpty) {
                    updateTrip(docID, userID);
                  }
                } catch (e) {
                  showErrDialog(context,
                      'Unknown error occurred when updating trip, please try again later');
                  log(e.toString());
                }
              } else {
                showErrDialog(context,
                    "Topic text field is not yet met requirement, please fix it before submit!",
                    title: "Can't update trip!");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() async {
                    imgLink = null;
                    _image = null;
                    _pickImageFromGallery();
                  });
                },
                child: picUpload(),
              ),
              TextFormField(
                initialValue: widget.title,
                decoration: InputDecoration(
                  errorText: _errorText(topicCont, 3, v: widget.title),
                  labelText: 'Topic',
                ),
                onChanged: (value) => setState(() {
                  topicCont.text = value;
                }),
                onTap: () => setState(() {
                  topicCont.text = widget.title;
                }),
              ),
              TextFormField(
                initialValue: widget.location,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  suffixIcon: Icon(Icons.location_on),
                ),
                onChanged: (value) => setState(() {
                  locaCont.text = value;
                }),
              ),
              TextFormField(
                initialValue: widget.description,
                decoration: InputDecoration(
                  errorText: _errorText(descCont, null),
                  labelText: 'Description',
                ),
                onChanged: (value) => setState(() {
                  descCont.text = value;
                }),
                maxLines: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Date & Time:'),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final date = await datePicker(context);
                        if (date != null) {
                          setState(() {
                            savedDateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                savedDateTime.hour,
                                savedDateTime.minute);
                            print(savedDateTime);
                          });
                        }
                      },
                      child: Text(
                          '${savedDateTime.year}-${savedDateTime.month}-${savedDateTime.day}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final time = await pickTime(context);
                        if (time != null) {
                          setState(() {
                            savedDateTime = DateTime(
                                savedDateTime.year,
                                savedDateTime.month,
                                savedDateTime.day,
                                time.hour,
                                time.minute);
                            print(savedDateTime);
                          });
                        }
                      },
                      child: Text(
                          '${savedDateTime.hour.toString().padLeft(2, '0')}:${savedDateTime.minute.toString().padLeft(2, '0')}'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget picUpload() {
    return imgLink == null
        ? Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey[600],
            ),
          )
        : SizedBox(
            height: 200,
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Image.network(
                imgLink!,
                fit: BoxFit.contain,
              ),
              Icon(
                Icons.camera_alt,
                color: Colors.grey[600],
              ),
            ]),
          );
  }

  void _pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      setState(() async {
        _image = File(result.files.single.path!);
        imgLink = await _uploadImageToFirebase();
      });
    } else {
      // ignore: use_build_context_synchronously
      showErrDialog(context, 'No image selected.');
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> _uploadImageToFirebase() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: true,
      barrierLabel: 'Loading',
    );
    if (_image != null) {
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('tripPics/${path.basename(_image!.path)}');
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
          showSuccessDialog(context, 'selected image has been uploaded',
              'Upload complete', null, true);
        });
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          imgLink = imageUrl;
        });

        return imageUrl;
      } catch (e) {
        print('Error uploading image to Firebase: $e');
        showErrDialog(context, e.toString());
        return null;
      }
    }
  }

  Future<DateTime?> datePicker(BuildContext context) => showDatePicker(
      context: context,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now());

  Future<TimeOfDay?> pickTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  String? _errorText(TextEditingController controller, int? requiredLength,
      // ignore: unused_element
      {v = null}) {
    final text = controller.value.text;

    // if (v != null && (text.length > requiredLength!)) {
    //   return null;
    // }

    if (requiredLength != null) {
      if ((requiredLength > 0) && (text.isEmpty)) {
        return 'Can\'t be empty';
      } else if (text.length < requiredLength) {
        return 'Too short, required at least $requiredLength characters';
      }
    }

    return null;
  }

  // void addNewTrip(String userID ) {
  //   collection.add({
  //     'userID': userID,
  //     'title': topicCont.text.trim(),
  //     'content': descCont.text.trim(),
  //     'location': locaCont.text.trim(),
  //     'when': savedDateTime,
  //     'updatedTS': DateTime.now(),
  //     'attachment': imgLink ?? '',
  //   }).whenComplete(() => showSuccessDialog(
  //       context, 'Trip has been added', 'Added!', null, true));
  // }

  void updateTrip(String docID, String userID) {
    collection.doc(docID).update({
      'userID': userID,
      'title': topicCont.text.trim(),
      'content': descCont.text.trim(),
      'location': locaCont.text.trim(),
      'when': savedDateTime,
      'updatedTS': DateTime.now(),
      'attachment': imgLink ?? '',
    }).whenComplete(() => showSuccessDialog(
        context, 'Trip has been updated', 'Updated!', null, false));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Trip'),
          content: const Text('Are you sure you want to delete this trip?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteTrip(widget.id);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void deleteTrip(String docID) async {
    final tripDoc = await collection.doc(docID).get();
    final imageUrl = tripDoc.data()?['attachment'];

    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
        await imageRef.delete();
      } catch (e) {
        print('Error deleting image from Firebase Storage: $e');
      }
    }

    collection.doc(docID).delete().then((_) {
      showSuccessDialog(
          context, 'Trip has been deleted', 'Deleted!', null, false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }).catchError((error) {
      showErrDialog(context, 'Failed to delete trip: $error');
    });
  }
}
