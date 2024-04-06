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

class AddDestinationView extends StatefulWidget {
  AddDestinationView({super.key});

  @override
  State<AddDestinationView> createState() => _AddDestinationViewState();
}

class _AddDestinationViewState extends State<AddDestinationView> {
  final topicCont = TextEditingController();
  final descCont = TextEditingController();
  final locaCont = TextEditingController();
  File? _image;
  var imgLink;

  @override
  void dispose() {
    topicCont.dispose();
    descCont.dispose();
    locaCont.dispose();
    super.dispose();
  }

  DateTime savedDateTime = DateTime.now();

  final collection = p.collection;

  @override
  Widget build(BuildContext context) {
    final h = savedDateTime.hour.toString().padLeft(2, '0');
    final m = savedDateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Handle save action
              // bool canSubmit = true;
              if (_errorText(topicCont, 3) == null) {
                // if met required condition (title text length is must at least more than 3)
                // if ((descCont.text.isEmpty)) {
                //   // if desc box is empty
                //   try {
                //     collection.add({
                //       'title': topicCont.text.trim(),
                //       'when': savedDateTime,
                //       'updatedTS': DateTime.now()
                //     }).whenComplete(() => showSuccessDialog(
                //         context, 'Trip has been added', 'Added!', null, true));
                //   } catch (e) {
                //     showErrDialog(context,
                //         'Unknown error occured when adding new trip, please try again later');
                //     log(e.toString());
                //   }
                // }
                // else {
                try {
                  collection.add({
                    'userID': UserObject().getUserUID(),
                    'title': topicCont.text.trim(),
                    'content': descCont.text.trim(),
                    'location': locaCont.text.trim(),
                    'when': savedDateTime,
                    'updatedTS': DateTime.now(),
                    'attachment': imgLink ?? '',
                  }).whenComplete(() => showSuccessDialog(
                      context, 'Trip has been added', 'Added!', null, true));
                } catch (e) {
                  showErrDialog(context,
                      'Unknown error occured when adding new trip, please try again later');
                  log(e.toString());
                }
                // }
              } else {
                // canSubmit = false;
                showErrDialog(context,
                    "Topic text field is not yet met requirement, please fix it before submit!",
                    title: "Can't add trip!");
                // canSubmit = true; // update it
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
                  // Handle import photo
                  setState(() async {
                    imgLink = null;
                    _image = null;
                    _pickImageFromGallery();
                  });
                },
                child: picUpload(),
              ),
              TextFormField(
                controller: topicCont,
                // validator: (value) => ,
                decoration: InputDecoration(
                  errorText: _errorText(topicCont, 3),
                  labelText: 'Topic',
                ),
                onChanged: (value) => setState(() {
                  topicCont.text;
                }),
              ),
              TextFormField(
                controller: locaCont,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  suffixIcon: Icon(Icons.location_on),
                ),
              ),
              TextFormField(
                controller: descCont,
                decoration: InputDecoration(
                  errorText: _errorText(descCont, null),
                  labelText: 'Description',
                ),
                onChanged: (value) => setState(() {
                  descCont.text;
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
                          if (date == null) {
                            return; // click cancel
                          } else {
                            setState(() {
                              savedDateTime = date;
                            });
                            // setState(() {
                            //   savedDateTime = DateTime.now();
                            // });
                          }
                        },
                        child: Text(
                            '${savedDateTime.year}-${savedDateTime.month}-${savedDateTime.day}')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final time = await pickTime(context);
                          if (time == null) {
                            return; // click cancel
                          } else {
                            setState(() {
                              savedDateTime = DateTime(
                                  savedDateTime.year,
                                  savedDateTime.month,
                                  savedDateTime.day,
                                  time.hour,
                                  time.minute);
                            });
                          }
                        },
                        child: Text('$h:$m')),
                  )
                ],
              )
              // InputDatePickerFormField(
              //   firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              //   lastDate: DateTime.now(),
              //   onDateSaved: (value) => savedDateTime = value,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget picUpload() {
    return imgLink == null
        ? Container(
            height: 200, // Set the image container height
            decoration: BoxDecoration(
              color: Colors.grey[300], // Placeholder color
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.camera_alt, // Placeholder icon
              color: Colors.grey[600],
            ),
          )
        : SizedBox(
            height: 200,
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Image.network(
                imgLink,
                fit: BoxFit.contain,
              ),
              Icon(
                Icons.camera_alt, // Placeholder icon
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
      showErrDialog(context, 'No image selected.');
    }
  }

  _uploadImageToFirebase() async {
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
        Reference ref = FirebaseStorage.instance.ref().child(
            'tripPics/${path.basename(_image!.path)}'); // Unique path for the image
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

        // Now you can save the imageUrl along with other trip details to Firestore
        // For example:
        // collection.add({
        //   'userID': UserObject().getUserUID(),
        //   'title': topicCont.text.trim(),
        //   'content': descCont.text.trim(),
        //   'location': locaCont.text.trim(),
        //   'when': savedDateTime,
        //   'imageURL': imageUrl, // Save the image URL here
        //   'updatedTS': DateTime.now()
        // }).whenComplete(() => showSuccessDialog(
        //       context, 'Trip has been added', 'Added!', null, true));
      } catch (e) {
        print('Error uploading image to Firebase: $e');
        showErrDialog(context, e.toString());
        return null;
      }
    }
  }

  Future<DateTime?> datePicker(context) => showDatePicker(
      context: context,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now());

  Future<TimeOfDay?> pickTime(context) =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  String? _errorText(TextEditingController _controller, int? requiredLength) {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here

    if (requiredLength != null) {
      if ((requiredLength > 0) && (text.isEmpty)) {
        return 'Can\'t be empty';
      } else if (text.length < requiredLength) {
        return 'Too short, required at least $requiredLength characters';
      }
    }

    // return null if the text is valid
    return null;
  }
}
