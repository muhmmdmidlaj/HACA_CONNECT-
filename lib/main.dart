import 'dart:html' as html; // For accessing browser API
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:haca_review_main/View/aouth_handler.dart';
import 'package:haca_review_main/controllers/provider/forget_pass_provider.dart';
import 'package:provider/provider.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/sigin.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/admin_issue_provider.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/controllers/provider/signup_provider.dart';
import 'package:haca_review_main/controllers/provider/tabar_provider.dart';
import 'package:haca_review_main/controllers/provider/user_issue_get_provider.dart';
import 'package:haca_review_main/controllers/provider/user_issue_provider.dart';
import 'package:haca_review_main/controllers/provider/classIssueData.dart';
import 'package:haca_review_main/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Request full screen when the app loads
  void requestFullScreen() {
    try {
      final html.Element? document = html.document.documentElement;
      if (document != null) {
        document.requestFullscreen();
      }
    } catch (e) {
      debugPrint("Full Screen Request Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    requestFullScreen(); // Request full screen for web when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IssueData()),
        ChangeNotifierProvider(create: (context) => IssueProvider()),
        ChangeNotifierProvider(create: (context) => TabProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AdminIssueProvider()),
        ChangeNotifierProvider(create: (context) => UserIssueGetProvider()),
        ChangeNotifierProvider(create: (context) => ForgetPassProvider()),
      ],
      child: MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   '/oauth/callback': (context) => const OAuthHandlerScreen(),
        //   '/home': (context) => const Home(),
        // },
        theme: ThemeData(
          fontFamily: 'poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: const InitialScreen(),
      ),
    );
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          debugPrint("Error checking user sign-in: ${snapshot.error}");
          return const Scaffold(
            body: Center(child: Text("Something went wrong!")),
          );
        } else {
          if (snapshot.data == true) {
            return FutureBuilder<String?>(
              future: Provider.of<AuthProvider>(context, listen: false)
                  .getUserRole(),
              builder: (context, AsyncSnapshot<String?> roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (roleSnapshot.hasError) {
                  debugPrint("Error fetching user role: ${roleSnapshot.error}");
                  return const Scaffold(
                    body: Center(child: Text("Error loading user role!")),
                  );
                } else if (roleSnapshot.hasData) {
                  String? role = roleSnapshot.data;
                  if (role == 'admin') {
                    return const AdminPage();
                  } else if (role == 'student') {
                    return const Home();
                  } else {
                    return const Sigin();
                  }
                } else {
                  return const Sigin();
                }
              },
            );
          } else {
            return const Sigin();
          }
        }
      },
    );
  }
}
