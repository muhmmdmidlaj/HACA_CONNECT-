import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/sigin.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/admin_issue_provider.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/controllers/provider/signup_provider.dart';
import 'package:haca_review_main/controllers/provider/tabar_provider.dart';
import 'package:haca_review_main/controllers/provider/user_issue_get_provider.dart';
import 'package:haca_review_main/controllers/provider/user_issue_provider.dart';
import 'package:provider/provider.dart';
import 'package:haca_review_main/controllers/provider/classIssueData.dart';

void main() async {
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => IssueProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TabProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AdminIssueProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserIssueGetProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'poppins',
            ),
            debugShowCheckedModeBanner: false,
            home: const InitialScreen()));
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<AuthProvider>(context, listen: false).isUserSignedIn(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking for the token
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.data == true) {
            // User is signed in, now check their role
            return FutureBuilder<String?>(
              future: Provider.of<AuthProvider>(context, listen: false)
                  .getUserRole(),
              builder: (context, AsyncSnapshot<String?> roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  if (roleSnapshot.hasData) {
                    String? role = roleSnapshot.data;
                    if (role == 'admin') {
                      // If user is admin, show Admin page
                      return const AdminPage(); // Replace with your Admin page widget
                    } else if (role == 'student') {
                      // If user is a student, show Home page (or student dashboard)
                      return const Home(); // Replace with your Student Home page widget
                    } else {
                      // If role is not recognized, show a default page
                      return const Sigin(); // You could return an error page here if necessary
                    }
                  } else {
                    // If role is not available, show sign-in screen
                    return const Sigin();
                  }
                }
              },
            );
          } else {
            // User is not signed in, go to Sign-Up screen
            return const Sigin();
          }
        }
      },
    );
  }
}
