import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';

import 'package:haca_review_main/mobile/view/mobile_home.dart';
import 'package:haca_review_main/mobile/widget/image_row_mobile.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/button.dart';
import 'package:haca_review_main/widgets/chekbox.dart';
import 'package:haca_review_main/widgets/textField.dart';

class MobileSignup extends StatefulWidget {
  const MobileSignup({super.key});

  @override
  State<MobileSignup> createState() => _MobileSignupState();
}

class _MobileSignupState extends State<MobileSignup> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 17),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Mywidgets().mytextField(
                      labelText: 'Name',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Mywidgets().mytextField(
                      labelText: 'Email ID',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Mywidgets().mytextField(
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Mywidgets().mytextField(
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RememberMeCheckbox(
                        labelText: 'I agree with privacy and policy'),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Button().textbutton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      },
                      text: 'Sign-Up',
                      fontSize: 16,
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
    );
  }
}
