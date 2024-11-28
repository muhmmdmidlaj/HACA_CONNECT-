import 'package:cool_alert/cool_alert.dart';
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

//------------------------------------
dialogCoolBuilder(BuildContext context) {
  return CoolAlert.show(
    context: context,
    type: CoolAlertType.confirm,
    onConfirmBtnTap: () async {
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
    width: 200,
    confirmBtnText: 'Log out',
    cancelBtnText: 'Cancel',
    text: 'Are you sure you want to log out?',
    showCancelBtn: true,
    title: 'Log out',
    widget: Container(
      width: 100,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Log out',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
