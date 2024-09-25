import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/View/tab_bar.dart';
import 'package:haca_review_main/mobile/view/mobile_sigin.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';

import 'package:haca_review_main/widgets/textField.dart';

class Sigin extends StatelessWidget {
  const Sigin({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: constraints.maxWidth > 800
              ? Row(
                  children: [
                    // Left side with the sign-in form
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
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Mywidgets().mytextField(labelText: 'Email ID'),
                          const SizedBox(height: 20),
                          Mywidgets().mytextField(labelText: 'Password'),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RememberMeCheckbox(),
                              Text(
                                'Forgot Password ?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Button().textbutton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            text: 'Sign-In',
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text('Or'),
                          ),
                          const SizedBox(height: 20),
                          Button().textbutton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                              },
                              text: 'Sign in with Google',
                              image: Image.asset(
                                'asset/images/icons8-google-48.png',
                                height: 30,
                                width: 25,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(165, 255, 255, 255),
                              textColor: Colors.black),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Do you have an account? ',
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign-Up',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
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
                )
              : MobileSigin()),
    );
  }
}
