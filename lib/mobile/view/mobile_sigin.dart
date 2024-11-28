import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/aouth_handler.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/mobile/widget/image_row_mobile.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileSigin extends StatefulWidget {
  const MobileSigin({super.key});

  @override
  State<MobileSigin> createState() => _MobileSiginState();
}

class _MobileSiginState extends State<MobileSigin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginPrvdr, child) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, top: 27),
                      child: Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Enter Your Credentials to Continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 17),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Mywidgets().mytextField(
                          controller: loginPrvdr.emailController,
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        child: TextFormField(
                          controller: loginPrvdr.passwordController,
                          obscureText:
                              loginPrvdr.obscureText, // Controlled by provider
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginPrvdr.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: loginPrvdr
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
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // RememberMeCheckbox(),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminPage(),
                                  ));
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 20,
                        child: loginPrvdr.isLoading
                            ? const Center(
                                child:
                                    CircularProgressIndicator(), // Show loader
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: const Color(0xFF0075FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  // Validate the form before signing up
                                  if (_formKey.currentState!.validate()) {
                                    // Call the login method from AuthProvider
                                    String? loginError =
                                        await loginPrvdr.login();
                                    print(loginError);

                                    if (loginError == null) {
                                      // If login is successful, retrieve the role from SharedPreferences
                                      String? role = await loginPrvdr.getRole();

                                      // Check the role and redirect accordingly
                                      if (role == 'admin') {
                                        // Admin role, redirect to admin dashboard
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Login successful as Admin!",
                                          onConfirmBtnTap: () {
                                            // Navigate to Admin Dashboard
                                            Navigator.pop(
                                                context); // Dismiss the alert
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminPage(), // Your AdminDashboard widget
                                              ),
                                            );
                                          },
                                          autoCloseDuration: const Duration(
                                              seconds:
                                                  2), // Automatically close alert after 2 seconds
                                        );

                                        // Optionally navigate to Admin Dashboard automatically after the delay
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminPage(),
                                            ),
                                          );
                                        });
                                      } else if (role == 'student') {
                                        // Student role, redirect to user side
                                        if (context.mounted) {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            text:
                                                "Login successful as Student!",
                                            onConfirmBtnTap: () {
                                              // Navigate to User Side (e.g., Home page)
                                           // Dismiss the alert
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Home(), // Your Home widget for users
                                                ),
                                              );
                                            },
                                            autoCloseDuration: const Duration(
                                                seconds:
                                                    2), // Automatically close alert after 2 seconds
                                          );
                                        }

                                        // Optionally navigate to Home automatically after the delay
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          if (context.mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home(),
                                              ),
                                            );
                                          }
                                        });
                                      } else {
                                        // Handle other roles or unknown role (optional)
                                        if (context.mounted) {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            text:
                                                "Unknown role or error occurred!",
                                          );
                                        }
                                      }
                                    } else {
                                      // Login failed, show error alert
                                      if (context.mounted) {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: loginError,
                                        );
                                      }
                                    }
                                  }
                                },
                                child: const Text(
                                  'Sign-In',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text('Or'),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Button().textbutton(
                            onPressed: () async {
                              const googleAuthUrl =
                                  'http://localhost:3000/auth/google';

                              try {
                                // Parse the URL
                                final Uri googleAuthUri =
                                    Uri.parse(googleAuthUrl);

                                // Check if URL can be launched
                                if (await canLaunchUrl(googleAuthUri)) {
                                  // Use `launchUrl` with mode set to open in an external browser
                                  await launchUrl(
                                    googleAuthUri,
                                    mode: LaunchMode.externalApplication,
                                  );

                                  // Optional: Navigate to OAuthHandlerScreen if needed
                                  // if (context.mounted) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             OAuthHandlerScreen()),
                                  //   );
                                  // }
                                } else {
                                  throw 'Could not launch $googleAuthUrl';
                                }
                              } catch (error) {
                                print("Error launching Google Sign-In: $error");
                              }
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
                      ),
                    ),
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Siginup(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ImageRowphone().phoneimgrow(context),
          ),
        ],
      ),
    );
  }
}
