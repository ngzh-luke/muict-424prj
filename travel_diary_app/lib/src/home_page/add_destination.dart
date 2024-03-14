import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:travel_diary_app/src/helpers/dialoger.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;

class AddDestinationView extends StatefulWidget {
  AddDestinationView({super.key});

  @override
  State<AddDestinationView> createState() => _AddDestinationViewState();
}

class _AddDestinationViewState extends State<AddDestinationView> {
  final topicCont = TextEditingController();
  final descCont = TextEditingController();

  @override
  void dispose() {
    topicCont.dispose();
    descCont.dispose();
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
              if ((_errorText(topicCont, 3) == null)) {
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
                    'when': savedDateTime,
                    'updatedTS': DateTime.now()
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Handle import photo
              },
              child: Container(
                height: 200, // Set the image container height
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.camera_alt, // Placeholder icon
                  color: Colors.grey[600],
                ),
                alignment: Alignment.center,
              ),
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
              decoration: const InputDecoration(
                labelText: 'Location',
                suffixIcon: Icon(Icons.search),
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
                ElevatedButton(
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
                ElevatedButton(
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
                    child: Text('$h:$m'))
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
    );
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
