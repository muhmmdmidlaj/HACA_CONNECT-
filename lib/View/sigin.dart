import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/aouth_handler.dart';
import 'package:haca_review_main/View/forget_paass_screen.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/mobile/view/mobile_sigin.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
import 'dart:html' as html; // For web functionality
import 'package:flutter/foundation.dart'; // For kIsWeb check

class Sigin extends StatefulWidget {
  const Sigin({super.key});

  @override
  State<Sigin> createState() => _SiginState();
}

class _SiginState extends State<Sigin> {
  final _appLinks = AppLinks(); // AppLinks instance for deep linking
  StreamSubscription<Uri>? _sub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  @override
  void initState() {
    super.initState();
    _checkDeepLinkOnSignIn();
  }

  void _handleIncomingLinks() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the user is logged in
    // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    _sub = _appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        // if (!isLoggedIn) {
        //   // Ignore deep links if the user is logged out
        //   print("User is not logged in, ignoring deep link.");
        //   return;
        // }
        await prefs.setBool('isLoggedIn', true);

        // Process deep links only when logged in
        String? accessToken = uri.queryParameters['accessToken'];
        String? refreshToken = uri.queryParameters['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          print("Access Token: $accessToken");
          print("Refresh Token: $refreshToken");

          // Store tokens
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('refreshToken', refreshToken);

          // Navigate to Home
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
      }
    }, onError: (err) {
      print("Error listening for deep links: $err");
    });
  }

  void _checkDeepLinkOnSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = await prefs.getBool('isLoggedIn');
    print('hiiiiiiiiiiiiiiiiiiiiiiiiii $isLoggedIn');

    if (isLoggedIn == true) {
      _handleIncomingLinks();
    }
    print("User is logged out, ignoring deep link.");
    return;
    // Handle deep links if the user is logged in
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: screenWidth > 700
            ? _buildDesktopLayout(screenWidth, screenHeight, loginProvider)
            : const MobileSigin(),
      ),
    );
  }

  Widget _buildDesktopLayout(
      double screenWidth, double screenHeight, LoginProvider loginProvider) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Container(
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
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Mywidgets().mytextField(
                  labelText: 'Email ID',
                  controller: loginProvider.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+\$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: TextFormField(
                    controller: loginProvider.passwordController,
                    obscureText:
                        loginProvider.obscureText, // Controlled by provider
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginProvider.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: loginProvider
                            .togglePasswordVisibility, // Toggle through provider
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPaassScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildSignInButton(loginProvider),
                const SizedBox(height: 20),
                const Center(child: Text('Or')),
                const SizedBox(height: 20),
                _buildGoogleSignInButton(),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign-Up',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Siginup()),
                              );
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton(LoginProvider loginProvider) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: loginProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF0075FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String? loginError = await loginProvider.login();

                  if (loginError == null) {
                    String? role = await loginProvider.getRole();
                    _navigateBasedOnRole(role);
                  } else {
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
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
    );
  }

  void _navigateBasedOnRole(String? role) {
    if (role == 'admin') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Login successful as Admin!",
        onConfirmBtnTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminPage()),
          );
        },
      );
    } else if (role == 'student') {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Login successful as Student!",
        onConfirmBtnTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Unknown role!",
      );
    }
  }

  Widget _buildGoogleSignInButton() {
    return Button().textbutton(
      onPressed: () async {
        const googleAuthUrl = 'http://localhost:3000/auth/google';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);  
        if (kIsWeb) {
          html.window.open(googleAuthUrl, "_self");
        } else {
          final uri = Uri.parse(googleAuthUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);

            // After successful OAuth flow, set isLoggedIn
          } else {
            print("Could not launch $googleAuthUrl");
          }
        }
      },
      text: 'Sign in with Google',
      image: Image.asset(
        'asset/images/icons8-google-48.png',
        height: 30,
        width: 25,
      ),
      backgroundColor: const Color.fromARGB(165, 255, 255, 255),
      textColor: Colors.black,
    );
  }
}
