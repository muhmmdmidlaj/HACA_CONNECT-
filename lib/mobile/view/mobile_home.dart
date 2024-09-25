import 'package:flutter/material.dart';
import 'package:haca_review_main/View/home.dart';
import 'package:haca_review_main/View/issuepage.dart';
import 'package:haca_review_main/View/logout.dart';
import 'package:haca_review_main/controllers/provider/user_issue_provider.dart';
import 'package:haca_review_main/widgets/diloge_builder.dart';
import 'package:provider/provider.dart';

class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {
    final issueProvider = Provider.of<IssueProvider>(context);

    return SingleChildScrollView(
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
                    children: const [
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
                            MaterialPageRoute(builder: (context) => Home()));
                      } else if (value == 'Myissue') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IssuePage()));
                      } else if (value == 'Logout') {
                        dialogBuilder(context);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Home', 'Myissue', 'Logout'}.map((String choice) {
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
              controller: issueProvider.titleController,
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
            ),
            const SizedBox(height: 12),

            // Urgency Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Urgency',
              ),
              value: issueProvider.selectedUrgency,
              items: ['Low', 'Medium', 'High'].map((urgency) {
                return DropdownMenuItem<String>(
                  value: urgency,
                  child: Text(urgency),
                );
              }).toList(),
              onChanged: (value) {
                issueProvider.setUrgency(value);
              },
            ),
            const SizedBox(height: 12),

            // Description Field
            TextField(
              controller: issueProvider.descriptionController,
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
                  issueProvider.saveIssue(context);
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
    );
  }
}
