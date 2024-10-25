import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/tab_bar.dart';
import 'package:haca_review_main/controllers/provider/signup_provider.dart';
import 'package:haca_review_main/mobile/view/mobile_signup.dart';
import 'package:haca_review_main/models/siginup_model.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';

class Siginup extends StatelessWidget {
  const Siginup({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a GlobalKey to manage the form state
    final _formKey = GlobalKey<FormState>();

    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(builder: (context, constraints) {
      return Consumer<AuthProvider>(
        builder: (context, signupPrvdr, child) => Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(),
            body: constraints.maxWidth > 800
                ? Row(children: [
                    // Left side with the sign-up form
                    Container(
                      width: screenWidth * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Form(
                        key: _formKey, // Assign the form key
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create Account',
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

                            // Name field with validation
                            Mywidgets().mytextField(
                              controller: signupPrvdr.nameController,
                              labelText: 'Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Email field with validation
                            Mywidgets().mytextField(
                              controller: signupPrvdr.emailController,
                              labelText: 'Email ID',
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

                            // Password field with validation
                            Mywidgets().mytextField(
                              controller: signupPrvdr.passwordController,
                              labelText: 'Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Confirm Password field with validation
                            Mywidgets().mytextField(
                              controller: signupPrvdr.conformPassController,
                              labelText: 'Confirm Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value !=
                                    signupPrvdr.passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // Privacy checkbox (validation if needed)
                            // const Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     RememberMeCheckbox(
                            //         labelText:
                            //             'I agree with privacy and policy'),
                            //   ],
                            // ),
                            const SizedBox(height: 30),

                            // Sign-Up Button
                            Button().textbutton(
                              onPressed: () async {
                                // Validate the form before signing up
                                if (_formKey.currentState!.validate()) {
                                  // Create UserModel object
                                  UserModel user = UserModel(
                                    name: signupPrvdr.nameController.text,
                                    email: signupPrvdr.emailController.text,
                                    password:
                                        signupPrvdr.passwordController.text,
                                    confirmPassword:
                                        signupPrvdr.conformPassController.text,
                                  );

                                  // Call the signup method from AuthProvider
                                  String? signupError =
                                      await signupPrvdr.signup(user);

                                  if (signupError == null) {
                                    // Signup successful, show success CoolAlert
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      text: "Sign up was successful!",
                                      onConfirmBtnTap: () {
                                        // Close the alert and navigate immediately
                                        Navigator.pop(
                                            context); // Dismiss the alert
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Home(),
                                          ),
                                        );
                                      },
                                      autoCloseDuration: Duration(
                                          seconds:
                                              2), // Automatically close alert after 2 seconds
                                    );

                                    // Automatically navigate to Home screen after the delay
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    });
                                  } else {
                                    // Signup failed, show error CoolAlert
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: signupError,
                                    );
                                  }
                                }
                              },
                              text: 'Sign-Up',
                            ),
                            Imgaerow().imgrow()
                          ],
                        ),
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
                  ])
                : MobileSignup()),
      );
    });
  }
}
