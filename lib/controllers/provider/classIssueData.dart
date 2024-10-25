import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/get_access_tocken.dart';
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

  void setIssueData(String title, String description, String category,
      String school, String modeOfClass, String batch) async {
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
        description: _description);
    _isLoading = true;
    notifyListeners();
    print(issue);

    final url = Uri.parse('http://localhost:3000/issue/raiseIssue');

    try {
      // Retrieve access token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        return "Access token not found. Please log in again.";
      }

      // Pass access token in the headers
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
      } else if (response.statusCode == 401) {
        // If the status code is 401 (unauthorized), try to regenerate the access token
        String? tokenError = await regenerateAccessToken();

        if (tokenError == null) {
          // Retry the request with the new access token if token was refreshed successfully
          return raiseIssue();
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
}
