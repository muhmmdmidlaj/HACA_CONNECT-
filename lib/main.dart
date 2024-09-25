import 'package:flutter/material.dart';
import 'package:haca_review_main/View/sigin.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/controllers/provider/tabar_provider.dart';
import 'package:haca_review_main/controllers/provider/user_issue_provider.dart';
import 'package:haca_review_main/mobile/view/mobile_signup.dart';
import 'package:haca_review_main/mobile/view/respopnsive_view/responsive_signup.dart';

import 'package:haca_review_main/mobile/view/mobile_sigin.dart';

import 'package:provider/provider.dart';
import 'package:haca_review_main/models/classIssueData.dart';

// import 'package:haca_review_main/View/sigin.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IssueData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => IssueProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TabProvider(),
      ),
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: Sigin()));

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sigin(),
    );

  }
}
