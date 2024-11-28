import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/issuepage.dart';
import 'package:haca_review_main/controllers/provider/classIssueData.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:provider/provider.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  String? _selectedCategory;
  String? _selectedSchool;
  String? _selectedModeOfClass;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Consumer<IssueData>(
      builder: (context, issueProvider, child) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome message and menu icon
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'student',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.menu, size: 35),
                              onSelected: (String value) {
                                if (value == 'Home') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                } else if (value == 'Myissue') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const IssuePage()));
                                } else if (value == 'Logout') {
                                  dialogCoolBuilder(context);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return {'Home', 'Myissue', 'Logout'}
                                    .map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Submit New Issue',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a title'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
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
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'School',
                        ),
                        value: _selectedSchool,
                        items: [
                          'Coding School',
                          'Marketing School',
                          'Design School',
                          'Finance School',
                        ].map((school) {
                          return DropdownMenuItem<String>(
                            value: school,
                            child: Text(school),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSchool = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a school' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: issueProvider.batchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Batch',
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter the batch'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mode of Class',
                        ),
                        value: _selectedModeOfClass,
                        items: [
                          'Online',
                          'Offline',
                        ].map((mode) {
                          return DropdownMenuItem<String>(
                            value: mode,
                            child: Text(mode),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedModeOfClass = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Please select the mode of class'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: issueProvider.descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a description'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: issueProvider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    issueProvider.setIssueData(
                                      title: _titleController.text.toString(),
                                      description: _descriptionController.text
                                          .toString(),
                                      category: _selectedCategory ?? 'N/A',
                                      school: _selectedSchool ?? 'N/A',
                                      modeOfClass:
                                          _selectedModeOfClass ?? 'N/A',
                                      batch: _batchController.text.toString(),
                                    );
                                    String? issueError =
                                        await issueProvider.raiseIssue();

                                    if (issueError == null) {
                                      // Success response
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        text: "Issue raised successfully!",
                                        onConfirmBtnTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const IssuePage(),
                                            ),
                                          );
                                          // Close alert
                                          issueProvider
                                              .clearFields(); // Clear form
                                        },
                                      );
                                    } else {
                                      // Error response
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: issueError,
                                      );
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: issueProvider.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            if (issueProvider.isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
