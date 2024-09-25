import 'package:flutter/material.dart';

class IssueProvider extends ChangeNotifier {
  // Controllers for form fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedUrgency;

  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setUrgency(String? value) {
    selectedUrgency = value;
    notifyListeners();
  }

  // Save issue data
  void saveIssue(BuildContext context) {
    if (selectedCategory == null || selectedUrgency == null || titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    
    // Save the data using a provider or any other service
    // Provider.of<IssueData>(context, listen: false).setIssueData(
    //   titleController.text,
    //   descriptionController.text,
    //   selectedCategory ?? 'N/A',
    //   selectedUrgency ?? 'N/A',
    // );

    // Clear the form fields
    clearFields();
  }

  // Clear form fields
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    selectedCategory = null;
    selectedUrgency = null;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
