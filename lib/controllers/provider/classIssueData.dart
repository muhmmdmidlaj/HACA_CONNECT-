import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/get_access_tocken.dart';
import 'package:haca_review_main/models/base_url.dart';
import 'dart:convert';

import 'package:haca_review_main/models/issue_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IssueData with ChangeNotifier {
  String _title = '';
  String _description = '';
  String _category = '';
  String _school = '';
  String _modeOfClass = '';
  String _batch = '';

  String get title => _title;
  String get description => _description;
  String get category => _category;
  String get school => _school;
  String get modeOfclass => _modeOfClass;
  String get btach => _batch;

  void setIssueData({
    required String title,
    required String description,
    required String category,
    required String school,
    required String modeOfClass,
    required String batch,
  }) async {
    _title = title;
    _description = description;
    _category = category;
    _school = school;
    _modeOfClass = modeOfClass;
    _batch = batch;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Function to raise an issue with access token in the headers
  Future<String?> raiseIssue() async {
    IssueModel issue = IssueModel(
      title: _title,
      category: _category,
      school: _school,
      batch: _batch,
      modeofClass: _modeOfClass,
      description: _description,
    );
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrlll/issue/raiseIssue');

    try {
      // Retrieve access token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        return "Access token not found. Please log in again.";
      }

      // Attempt to raise the issue with the access token in the headers
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Include the access token
        },
        body: json.encode(issue.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful issue raise
        final responseData = json.decode(response.body);
        print("Issue raised successfully: $responseData");

        // Return null to indicate success
        return null;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Access token is invalid, try to regenerate it
        print('Access token expired. Attempting to regenerate...');
        String? tokenError = await regenerateAccessToken();

        if (tokenError == null) {
          // If token was successfully regenerated, retry raising the issue
          return await raiseIssue();
        } else {
          // Return error if token refresh failed
          return tokenError;
        }
      } else {
        // Handle other error responses
        return "Issue raise failed with status code: ${response.statusCode}";
      }
    } catch (error) {
      // Handle network or other errors
      return "Error occurred: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
    print(_selectedMode);

    notifyListeners();
  }

  void setCategory(String? value) {
    selectedCategory = value;
    print(selectedCategory);
    notifyListeners();
  }

  void setSelectedSchool(String? school) {
    selectedSchool = school;
    print(selectedSchool);
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
