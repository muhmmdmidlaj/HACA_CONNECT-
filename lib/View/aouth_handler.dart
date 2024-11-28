import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haca_review_main/View/home.dart';
// import 'dart:html' as html; // Import for web-only functionality
import 'dart:async';

// class OAuthHandlerScreen extends StatefulWidget {
//   const OAuthHandlerScreen({super.key});

//   @override
//   _OAuthHandlerScreenState createState() => _OAuthHandlerScreenState();
// }

// class _OAuthHandlerScreenState extends State<OAuthHandlerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Delay to ensure everything is initialized
//     Future.delayed(const Duration(milliseconds: 500), _initializePreferences);
//   }

//   Future<void> _initializePreferences() async {
//     await captureAndStoreTokens(); // Capture tokens from URL and store them
//     await _checkAndNavigate(); // Check tokens and navigate if available
//   }

//   Future<void> captureAndStoreTokens() async {
//     // Parse the current URL for query parameters
//     final uri = Uri.base;
//     print('uri link :$uri');
//     final accessToken = uri.queryParameters['accessToken'];
//     final refreshToken = uri.queryParameters['refreshToken'];

//     if (accessToken != null && refreshToken != null) {
//       // Save tokens to SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('accessToken', accessToken);
//       await prefs.setString('refreshToken', refreshToken);
//       print(
//           "Tokens saved successfully: AccessToken=$accessToken, RefreshToken=$refreshToken");
//     } else {
//       print("Tokens not found in the callback URL.");
//     }
//   }

//   Future<void> _checkAndNavigate() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     print('handleeeeeeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrrr');

//     // Retrieve tokens from SharedPreferences
//     String? accessToken = prefs.getString('accessToken');
//     String? refreshToken = prefs.getString('refreshToken');

//     print("Access Token from SharedPreferences: $accessToken");
//     print("Refresh Token from SharedPreferences: $refreshToken");

//     if (accessToken != null && refreshToken != null) {
//       _navigateToHome();
//     } else {
//       print("Tokens not found in SharedPreferences.");
//     }
//   }

//   void _navigateToHome() {
//     print(
//         'handleeeeeeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrrr navigateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => Home()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

class OAuthHandlerScreen extends StatefulWidget {
  const OAuthHandlerScreen({super.key});

  @override
  _OAuthHandlerScreenState createState() => _OAuthHandlerScreenState();
}

class _OAuthHandlerScreenState extends State<OAuthHandlerScreen> {
  @override
  void initState() {
    super.initState();
    // Delay to ensure everything is initialized
    Future.delayed(const Duration(milliseconds: 500), _initializePreferences);
  }

  Future<void> _initializePreferences() async {
    await captureAndStoreTokens(); // Capture tokens from URL and store them
    await _checkAndNavigate(); // Check tokens and navigate if available
  }

  Future<void> captureAndStoreTokens() async {
    // Parse the current URL for query parameters
    final uri = Uri.base;
    print('uri link :$uri');
    final accessToken = uri.queryParameters['accessToken'];
    final refreshToken = uri.queryParameters['refreshToken'];

    if (accessToken != null && refreshToken != null) {
      // Save tokens to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('refreshToken', refreshToken);
      print(
          "Tokens saved successfully: AccessToken=$accessToken, RefreshToken=$refreshToken");
    } else {
      print("Tokens not found in the callback URL.");
    }
  }

  Future<void> _checkAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('handleeeeeeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrrr');

    // Retrieve tokens from SharedPreferences
    String? accessToken = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');

    print("Access Token from SharedPreferences: $accessToken");
    print("Refresh Token from SharedPreferences: $refreshToken");

    if (accessToken != null && refreshToken != null) {
      _navigateToHome();
    } else {
      print("Tokens not found in SharedPreferences.");
    }
  }

  void _navigateToHome() {
    print(
        'handleeeeeeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrrrrrrrrrrrrrrr navigateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
