import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/issuepage.dart';
import 'package:haca_review_main/View/myIssues.dart';
import 'package:haca_review_main/mobile/view/mobile_home.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:provider/provider.dart';
import 'package:haca_review_main/controllers/provider/classIssueData.dart';
import 'package:haca_review_main/widgets/appbar.dart';
import 'dart:html' as html;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _handleRedirectAndNavigate();
  }

  String _selectedButton = 'Home';
  Color defaultColor = Colors.black;
  Color selectedColor = Colors.blue;
  String username = 'Shibili';

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  String? _selectedCategory;
  String? _selectedSchool;
  String? _selectedModeOfClass;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  void _handleRedirectAndNavigate() async {
    // Adding a delay to ensure that the URL is fully loaded
    Future.delayed(Duration(milliseconds: 500), () {
      Uri uri = Uri.parse(html.window.location.href);
      String? accessToken = uri.queryParameters['accessToken'];
      String? refreshToken = uri.queryParameters['refreshToken'];

      // Debugging output
      print('Full URL: ${html.window.location.href}');
      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');

      if (accessToken != null && refreshToken != null) {
        // Store the tokens locally or use them for further requests
        html.window.localStorage['accessToken'] = accessToken;
        html.window.localStorage['refreshToken'] = refreshToken;

        // Navigate to home page or other logic after successful login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Home(),
          ));
        });
      } else {
        print(
            "Tokens not found. Redirect failed or user is not authenticated.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//

    //
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      return Consumer<IssueData>(
        builder: (context, issueProvider, child) => Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(),
            body: constraints.maxWidth > 800
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth < 600 ? 12.0 : 16.0),
                      child: Form(
                        key: _formKey, // Add the form key here
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Navigation row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  height: screenHeight * 0.1,
                                  width: screenWidth * 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          'Home',
                                          style: TextStyle(
                                            color: _selectedButton == 'Home'
                                                ? selectedColor
                                                : defaultColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedButton = 'Home';
                                          });
                                        },
                                      ),
                                      InkWell(
                                        child: Text(
                                          'My Issues',
                                          style: TextStyle(
                                            color:
                                                _selectedButton == 'My Issues'
                                                    ? selectedColor
                                                    : defaultColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedButton = 'My Issues';
                                          });

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                    const IssuePage()));
                                        },
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Log Out',
                                          style: TextStyle(
                                            color: _selectedButton == 'Log Out'
                                                ? selectedColor
                                                : defaultColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedButton = 'Log Out';
                                          });
                                          dialogBuilder(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Welcome message
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 80),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  ' $username',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Form section
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.only(left: 80),
                              child: Text(
                                'Submit New Issue',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Category and Urgency dropdowns with Title Field
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 80,
                              ),
                              child: SizedBox(
                                width: 1040,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _titleController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Title',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a title';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Category Dropdown
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Category',
                                        ),
                                        value: _selectedCategory,
                                        items: [
                                          'Academic',
                                          'Facilities',
                                          'Personal',
                                          'Technical',
                                          'Other'
                                        ].map((category) {
                                          return DropdownMenuItem<String>(
                                            value: category,
                                            child: Text(category),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCategory = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a category';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Urgency Dropdown
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 80,
                              ),
                              child: SizedBox(
                                width: 1040,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Schools',
                                        ),
                                        value: _selectedSchool,
                                        items: [
                                          'Coding School',
                                          'Marketing School',
                                          'Design School',
                                          'Finance School'
                                        ].map((urgency) {
                                          return DropdownMenuItem<String>(
                                            value: urgency,
                                            child: Text(urgency),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedSchool = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a school';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _batchController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Batch',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the batch';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Mode of Class Dropdown
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Mode of Class',
                                        ),
                                        value: _selectedModeOfClass,
                                        items: [
                                          'Offline',
                                          'Online',
                                        ].map((category) {
                                          return DropdownMenuItem<String>(
                                            value: category,
                                            child: Text(category),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedModeOfClass = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select the mode of class';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Description Field
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Container(
                                height: 177,
                                width: 1025,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextFormField(
                                  controller: _descriptionController,
                                  maxLines: 8,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Description',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a description';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Submit Button
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Container(
                                width: 327,
                                height: 52,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Validate form before submitting
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      // Save the data using the provider
                                      Provider.of<IssueData>(context,
                                              listen: false)
                                          .setIssueData(
                                        _titleController.text.toString(),
                                        _descriptionController.text.toString(),
                                        _selectedCategory ?? 'N/A',
                                        _selectedSchool ?? 'N/A',
                                        _selectedModeOfClass ?? 'N/A',
                                        _batchController.text.toString(),
                                      );
                                      String? issueError =
                                          await issueProvider.raiseIssue();

                                      if (issueError == null) {
                                        // If the issue is successfully raised, show success alert
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Issue raised successfully!",
                                          onConfirmBtnTap: () {
                                            // Close the alert and clear the form fields
                                            Navigator.pop(
                                                context); // Dismiss the alert
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const IssuePage(),
                                              ),
                                            );
                                            _titleController.clear();
                                            _descriptionController.clear();
                                            _batchController.clear();

                                            // Clear dropdown selections
                                            setState(() {
                                              _selectedCategory = null;
                                              _selectedSchool = null;
                                              _selectedModeOfClass = null;
                                            });
                                          },
                                          autoCloseDuration: const Duration(
                                              seconds:
                                                  4), // Automatically close after 2 seconds
                                        );
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const IssuePage(),
                                            ),
                                          );
                                        });
                                      } else {
                                        // If there is an error, show an error alert
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: issueError,
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blueAccent,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const MobileHome()),
      );
    });
  }
}
