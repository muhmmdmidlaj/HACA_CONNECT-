import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/provider/forget_pass_provider.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'package:haca_review_main/widgets/imgaerow.dart';
import 'package:haca_review_main/widgets/textField.dart';
import 'package:provider/provider.dart';

class ForgetPaassScreen extends StatelessWidget {
  const ForgetPaassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController forgetController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      // appBar: CustomAppBar(),
      body: Consumer<ForgetPassProvider>(
        builder: (context, frgtPrvdr, child) => Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) => screenWidth > 700
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                            width: screenWidth * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/Favicon2.png',
                                  height: 250,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Text(
                                        "Please enter your registered email",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: Mywidgets().mytextField(
                                    labelText: 'Email',
                                    controller: forgetController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (!RegExp(
                                              r'^[^@]+@[^@]+\.[^@]+\$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30, top: 20),
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: frgtPrvdr.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
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
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // if (loginError == null) {

                                                // } else {
                                                //   CoolAlert.show(
                                                //     context: context,
                                                //     type: CoolAlertType.error,
                                                //     text: loginError,
                                                //   );
                                                // }
                                              }
                                            },
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                ),
                                Spacer(),
                                Imgaerow().imgrow(),
                              ],
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
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
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Reset your password to regain access to your dashboard, \nupdate your settings, and enjoy exclusive features',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [

                      
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
