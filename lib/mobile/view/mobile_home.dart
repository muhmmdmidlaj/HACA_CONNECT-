import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haca_review_main/models/classIssueData.dart';
import 'package:haca_review_main/widgets/appbar.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  String username = 'student'; // Updated to match the design
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _selectedUrgency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row containing Welcome message and Menu Icon
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          username,
                          style: const TextStyle(
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
                        // Handle menu actions here
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Home', 'Logout', 'Myissue'}
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
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 12),

              // Category Dropdown
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
              ),
              const SizedBox(height: 12),

              // Urgency Dropdown
              DropdownButtonFormField<String>(
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
              const SizedBox(height: 12),

              // Description Field
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  onPressed: () {
                    // Save the data using the provider
                    Provider.of<IssueData>(context, listen: false).setIssueData(
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
            ],
          ),
        ),
      ),
    );
  }
}
