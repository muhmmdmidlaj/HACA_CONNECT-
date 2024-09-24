import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';
import 'package:haca_review_main/widgets/textField.dart';

class Siginup extends StatelessWidget {
  const Siginup({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Row(children: [
        // Left side with the sign-in form
        Container(
          width: screenWidth * 0.4,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Account,,',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign up to get started',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Mywidgets().mytextField(labelText: 'Name'),
              const SizedBox(height: 20),
              Mywidgets().mytextField(labelText: 'Email ID'),
              const SizedBox(height: 20),
              Mywidgets().mytextField(labelText: 'Password'),
              const SizedBox(height: 20),
              Mywidgets().mytextField(labelText: 'Confirm Passwordd'),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RememberMeCheckbox(
                      labelText: 'I agree with privacy and policy'),
                ],
              ),
              const SizedBox(height: 30),
              Button().textbutton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                text: 'Sign-Up',
              ),
              Imgaerow().imgrow()
            ],
          ),
        ),

        // Right side with the blue background and "Sign-In" text
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
                  'Sign-Up',
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
      ]),
    );
  }
}
