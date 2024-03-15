import 'package:flutter/material.dart';

showSuccessDialog(BuildContext context, String msg, String title,
    String? navName, bool back) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
      if (back) {
        Navigator.of(context).pop();
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: (navName != null)
        ? [
            okButton,
            TextButton(
              child: const Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushNamed(navName); // dismiss dialog
              },
            )
          ]
        : [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showErrDialog(BuildContext context, String msg,
    {String title = 'Encountered error!'}) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showGenDialog(BuildContext context, String msg, String title) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showActionDialog(BuildContext context, String msg,
    {String title = "What's next?",
    action,
    String actionName = 'action'}) async* {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Dismiss"),
    onPressed: () {
      Navigator.of(context).pop(); // dismiss dialog
    },
  );

  Widget actionBtn = TextButton(onPressed: action, child: Text(actionName));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [okButton, actionBtn],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
