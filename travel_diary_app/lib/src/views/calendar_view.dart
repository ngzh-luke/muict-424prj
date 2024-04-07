import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/post_object.dart'
    as p;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_diary_app/src/helpers/cloud_helpers/user_object.dart';
import 'package:travel_diary_app/src/helpers/dialoger.dart';

class CalendarView extends StatefulWidget {
  CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime focusedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Calendar'),
        ),
        body: Column(
          children: [
            TableCalendar(
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              firstDay: DateTime.fromMillisecondsSinceEpoch(0),
              lastDay: DateTime.now().add(const Duration(days: 366)),
              currentDay: focusedDate,
              onDisabledDayTapped: (day) {
                showErrDialog(context, "Can't select the future date.");
              },
              focusedDay: focusedDate,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (selectedDay.day > DateTime.now().day) {
                    showErrDialog(context, "Please reselect a new date",
                        title: "Future date can't be selected!");
                  } else {
                    focusedDate = selectedDay;
                  }
                });
                // print('\nsel: $selectedDay\nfoc: $focusedDate');
              },
              onFormatChanged: (format) {
                // print('format: $format');
              },
            ),
            const Gap(5),
            Text(
                style: TextStyle(
                    color: Colors.amber[700],
                    decoration: TextDecoration.underline),
                "Selected date: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(focusedDate)}"),
            const Gap(4),
            desList(),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Padding desList() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 5.0, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.brown[300],
        ),
        child: Column(
          children: [
            Text(
              "Destinations",
              style: TextStyle(
                  color: Colors.cyan[300],
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 220,
                child: FutureBuilder<Widget>(
                  future: stream(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      showErrDialog(context, snapshot.error.toString());
                      return const Text('Error');
                    } else {
                      return snapshot.data!;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> stream() async {
    return StreamBuilder<QuerySnapshot>(
      stream: p.collection.orderBy('updatedTS', descending: true).snapshots(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          showErrDialog(context, snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return renderMyDiariesOnSelectedDate(p.collection, snapshot);
        } else {
          Navigator.of(context).pop();
        }
        return const Center();
      },
    );
  }

  Widget renderMyDiariesOnSelectedDate(
      CollectionReference d, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final userId = UserObject().getUserUID();
      final diaries = snapshot.data!.docs
          .where((doc) =>
              doc.get('when').toDate().year == focusedDate.year &&
              doc.get('when').toDate().month == focusedDate.month &&
              doc.get('when').toDate().day == focusedDate.day &&
              doc.get('userID') == userId)
          .toList();

      if (diaries.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return SizedBox(
        height: 100, // Set a fixed height
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: diaries.length,
          itemBuilder: (BuildContext context, int index) {
            final diary = diaries[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 100,
                width: 200, // Set a fixed width for each item
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    "${diary['title'] ?? ''} • ${diary['location'] ?? ''}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(child: Text('No data available, try add one!'));
    }
  }
}
