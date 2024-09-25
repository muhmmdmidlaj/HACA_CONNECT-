import 'package:flutter/material.dart';
import 'package:haca_review_main/View/issuepage.dart';

import 'package:haca_review_main/admin/homeres.dart';

import 'package:haca_review_main/mobile/view/mobile_home.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';

import 'package:provider/provider.dart';
import 'package:haca_review_main/models/classIssueData.dart';
import 'package:haca_review_main/View/myIssues.dart';
import 'package:haca_review_main/widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedButton = 'Home';
  Color defaultColor = Colors.black;
  Color selectedColor = Colors.blue;
  String username = 'Shibili';

  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _selectedUrgency;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: constraints.maxWidth > 800
              ? Padding(
                  padding: EdgeInsets.all(screenWidth < 600 ? 12.0 : 16.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      color: _selectedButton == 'My Issues'
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
                                            builder: (context) => IssuePage()));
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
                      const SizedBox(
                        height: 1,
                      ),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 52,
                              width: 327,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Title',
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Category Dropdown
                            Container(
                              height: 52,
                              width: 327,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Urgency Dropdown
                            Container(
                              height: 52,
                              width: 327,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Urgency',
                                ),
                                value: _selectedUrgency,
                                items: ['Low', 'Medium', 'High'].map((urgency) {
                                  return DropdownMenuItem<String>(
                                    value: urgency,
                                    child: Text(urgency),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUrgency = value;
                                  });
                                },
                              ),
                            ),
                          ],
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
                              onPressed: () {
                                // Save the data using the provider
                                Provider.of<IssueData>(context, listen: false)
                                    .setIssueData(
                                  _titleController.text,
                                  _descriptionController.text,
                                  _selectedCategory ?? 'N/A',
                                  _selectedUrgency ?? 'N/A',
                                );

                                // Clear the form fields
                                _titleController.clear();
                                _descriptionController.clear();

                                // Update the UI to clear dropdown selections
                                setState(() {
                                  _selectedCategory = null;
                                  _selectedUrgency = null;
                                });
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
                            )),
                      ),
                    ],
                  ),
                )
              : MobileHome());
    });
  }
}
