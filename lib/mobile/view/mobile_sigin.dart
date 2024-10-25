import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/siginup.dart';
import 'package:haca_review_main/admin/homeres.dart';
import 'package:haca_review_main/controllers/provider/login_provider.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/mobile/widget/image_row_mobile.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';

class MobileSigin extends StatefulWidget {
  const MobileSigin({super.key});

  @override
  State<MobileSigin> createState() => _MobileSiginState();
}

class _MobileSiginState extends State<MobileSigin> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginPrvdr, child) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      width: MediaQuery.of(context).size.width - 20,
                      child: Mywidgets().mytextField(
                        controller: loginPrvdr.passwordController,
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
                                  builder: (context) => Adminpage(),
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
                      child: Button().textbutton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                        text: 'Sign-In',
                        fontSize: 16,
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
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const Home()),
                          // );
                        },
                        text: 'Sign in with Google',
                        image: Image.asset(
                          'asset/images/icons8-google-48.png',
                          height: 57,
                          width: 32,
                        ),
                        backgroundColor:
                            const Color.fromARGB(165, 255, 255, 255),
                        textColor: Colors.black,
                      ),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ImageRowphone().phoneimgrow(context),
          ),
        ],
      ),
    );
  }
}
