import 'package:flutter/material.dart';

class IssueProvider extends ChangeNotifier {
  // Controllers for form fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  String? selectedModeOfClass;

  String? selectedCategory;
  String? selectedSchool;
  String? _selectedMode;

  String? get selectedMode => _selectedMode;

  void setSelectedMode(String? mode) {
    _selectedMode = mode;
    notifyListeners();
  }

  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setSelectedSchool(String? school) {
    selectedSchool = school;
    notifyListeners();
  }

  // Save issue data
  void saveIssue(BuildContext context) {
    if (selectedCategory == null ||
        selectedSchool == null ||
        titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
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
    selectedSchool = null;
    batchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
