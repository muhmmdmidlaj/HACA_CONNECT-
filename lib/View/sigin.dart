import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/mobile/view/mobile_sigin.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:app_links/app_links.dart';

class Sigin extends StatefulWidget {
  const Sigin({super.key});

  @override
  State<Sigin> createState() => _SiginState();
}

class _SiginState extends State<Sigin> {
  final _appLinks = AppLinks(); // Create an instance of AppLinks
  StreamSubscription<Uri>? _sub;

  void initState() {
    super.initState();
    _handleIncomingLinks(); // Start listening for deep link redirects
  }

  // Listen for incoming deep links
  void _handleIncomingLinks() {
    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // Extract tokens from the deep link URI
        String? accessToken = uri.queryParameters['accessToken'];
        String? refreshToken = uri.queryParameters['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          // Store tokens and navigate to home screen
          print("Access Token: $accessToken");
          print("Refresh Token: $refreshToken");

          // Navigate to home page after successful login
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      }
    }, onError: (err) {
      print("Error listening for deep links: $err");
    });
  }

  // Dispose the subscription when no longer needed
  @override
  void dispose() {
    _sub?.cancel(); // Clean up the subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();

    return Consumer<LoginProvider>(
      builder: (context, loginprvdr, child) => LayoutBuilder(
        builder: (context, constraints) => Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(),
            body: constraints.maxWidth > 700
                ? Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        // Left side with the sign-in form
                        SingleChildScrollView(
                          child: Container(
                            width: screenWidth * 0.4,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Enter Your Credentials to Continue',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Mywidgets().mytextField(
                                  labelText: 'Email ID',
                                  controller: loginprvdr.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Mywidgets().mytextField(
                                  labelText: 'Password',
                                  controller: loginprvdr.passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // RememberMeCheckbox(),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminPage(),
                                                    ));
                                              },
                                              child: Text(
                                                'Forgot Password ?',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: loginprvdr.isLoading
                                        ? const Center(
                                            child:
                                                CircularProgressIndicator(), // Show loader
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              backgroundColor:
                                                  const Color(0xFF0075FF),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () async {
                                              // Validate the form before signing up
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // Call the login method from AuthProvider
                                                String? loginError =
                                                    await loginprvdr.login();
                                                print(loginError);

                                                if (loginError == null) {
                                                  // If login is successful, retrieve the role from SharedPreferences
                                                  String? role =
                                                      await loginprvdr
                                                          .getRole();

                                                  // Check the role and redirect accordingly
                                                  if (role == 'admin') {
                                                    // Admin role, redirect to admin dashboard
                                                    CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.success,
                                                      text:
                                                          "Login successful as Admin!",
                                                      onConfirmBtnTap: () {
                                                        // Navigate to Admin Dashboard
                                                        Navigator.pop(
                                                            context); // Dismiss the alert
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AdminPage(), // Your AdminDashboard widget
                                                          ),
                                                        );
                                                      },
                                                      autoCloseDuration: Duration(
                                                          seconds:
                                                              2), // Automatically close alert after 2 seconds
                                                    );

                                                    // Optionally navigate to Admin Dashboard automatically after the delay
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AdminPage(),
                                                        ),
                                                      );
                                                    });
                                                  } else if (role ==
                                                      'student') {
                                                    // Student role, redirect to user side
                                                    CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.success,
                                                      text:
                                                          "Login successful as Student!",
                                                      onConfirmBtnTap: () {
                                                        // Navigate to User Side (e.g., Home page)
                                                        Navigator.pop(
                                                            context); // Dismiss the alert
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Home(), // Your Home widget for users
                                                          ),
                                                        );
                                                      },
                                                      autoCloseDuration: Duration(
                                                          seconds:
                                                              2), // Automatically close alert after 2 seconds
                                                    );

                                                    // Optionally navigate to Home automatically after the delay
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Home(),
                                                        ),
                                                      );
                                                    });
                                                  } else {
                                                    // Handle other roles or unknown role (optional)
                                                    CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
                                                      text:
                                                          "Unknown role or error occurred!",
                                                    );
                                                  }
                                                } else {
                                                  // Login failed, show error alert
                                                  CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text: loginError,
                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              'Sign-In',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Center(
                                  child: Text('Or'),
                                ),
                                const SizedBox(height: 20),
                                Button().textbutton(
                                    onPressed: () async {
                                      // const url =
                                      //     'http://localhost:3000/auth/google';

                                      // // Check if the URL can be launched
                                      // if (await canLaunchUrl(Uri.parse(url))) {
                                      //   // Launch the URL
                                      //   await launchUrl(Uri.parse(url));
                                      // } else {
                                      //   // Handle error if the URL cannot be launched
                                      //   throw 'Could not launch $url';
                                      // }

                                      // Use html.window.open for Flutter web
                                      // if (kIsWeb) {
                                      //   // Use html.window.open for Flutter web
                                      //   const url =
                                      //       'http://localhost:3000/auth/google';
                                      //   html.window.open(url,
                                      //       "_self"); // Opens in the same tab
                                      // } else {
                                      //   // Handle for mobile or desktop if needed
                                      //   print(
                                      //       'This functionality is only for web.');
                                      // }

                                      // Open Google sign-in page in the external browser
                                      const googleAuthUrl =
                                          'http://localhost:3000/auth/google';

                                      // Check if URL can be launched
                                      if (await canLaunchUrl(
                                          Uri.parse(googleAuthUrl))) {
                                        await launchUrl(
                                            Uri.parse(googleAuthUrl));
                                      } else {
                                        print(
                                            "Could not launch $googleAuthUrl");
                                      }
                                    },
                                    text: 'Sign in with Google',
                                    image: Image.asset(
                                      'asset/images/icons8-google-48.png',
                                      height: 30,
                                      width: 25,
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        165, 255, 255, 255),
                                    textColor: Colors.black),
                                const SizedBox(height: 20),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Do you have an account? ',
                                      style:
                                          const TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Sign-Up',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer:
                                              TapGestureRecognizer() // same like button
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Siginup()));
                                                },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Imgaerow().imgrow(),
                              ],
                            ),
                          ),
                        ),

                        //  blue background and "Sign-In" text
                        Container(
                          width: screenWidth * 0.6,
                          height: screenHeight,
                          color: const Color(0xFF0075FF),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 65),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign-In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Sign in to access your personalized \ndashboard, manage your settings, and \nexplore exclusive features',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : MobileSigin()),
      ),
    );
  }
}

class HomePage {}
