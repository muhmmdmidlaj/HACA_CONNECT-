import 'package:flutter/material.dart';
import 'package:haca_review_main/View/sigin.dart';
import 'package:haca_review_main/controllers/provider/logout.dart';

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text(
          'Are you sure you want to log out?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Log Out'),
            onPressed: () async {
              await clearTokens();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Sigin(),
                  ),
                  (route) => false, 
                );
              }
            },
          ),
        ],
      );
    },
  );
}
