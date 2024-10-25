import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/issuepage.dart';
import 'package:haca_review_main/controllers/provider/user_issue_provider.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:provider/provider.dart';

class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {
    final issueProvider = Provider.of<IssueProvider>(context);
    final _formKey = GlobalKey<FormState>(); // Add the form key

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey, // Add the form key here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row containing Welcome message and Menu Icon
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
                    // Menu icon aligned to the right
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.menu, size: 35),
                      onSelected: (String value) {
                        if (value == 'Home') {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Home()));
                        } else if (value == 'Myissue') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const IssuePage()));
                        } else if (value == 'Logout') {
                          dialogBuilder(context);
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

              // Submit New Issue Header
              const Text(
                'Submit New Issue',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Title Field
              TextFormField(
                controller: issueProvider.titleController,
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
              const SizedBox(height: 12),

              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                value: issueProvider.selectedCategory,
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
                  issueProvider.setCategory(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Urgency Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Schools',
                ),
                value: issueProvider.selectedSchool,
                items: [
                  'Coding School',
                  'Marketing School',
                  'Design School',
                  'Finance School',
                ].map((urgency) {
                  return DropdownMenuItem<String>(
                    value: urgency,
                    child: Text(urgency),
                  );
                }).toList(),
                onChanged: (value) {
                  issueProvider.setSelectedSchool(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a school';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Batch Field
              TextFormField(
                controller: issueProvider.batchController,
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
              const SizedBox(height: 12),

              // Mode of Class Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mode of Class',
                ),
                value: issueProvider.selectedMode,
                items: [
                  'Online',
                  'Offline',
                ].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  issueProvider.setSelectedMode(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the mode of class';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Description Field
              TextFormField(
                controller: issueProvider.descriptionController,
                maxLines: 3,
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
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                height: 50,
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Save issue if form is valid
                      issueProvider.saveIssue(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Match the button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
