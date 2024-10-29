import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/get_access_tocken.dart';
import 'package:haca_review_main/models/issue_get_model.dart';
import 'package:haca_review_main/models/issue_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminIssueProvider with ChangeNotifier {
  // Base URL for the API
  final String _baseUrl = 'http://192.168.1.211:3000/issue/allComplaints';

  // Internal list of complaints to keep track of fetched data
  List<Complaint> _complaints = [];

  // Getter for complaints list (can still be used with ChangeNotifier if needed)
  List<Complaint> get complaints => _complaints;

  // List of predefined statuses for the complaints
  final List<String> statuses = ['Resolved', 'Ongoing', 'Pending'];
  // Fetch complaints with access token in headers
  Future<List<Complaint>> fetchComplaints() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      final url = Uri.parse(_baseUrl);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Successfully fetched complaints
        final Map<String, dynamic> data = json.decode(response.body);
        ComplaintsResponse complaintsResponse =
            ComplaintsResponse.fromJson(data);

        _complaints = complaintsResponse.complaints;
        print('Fetched complaints: ${_complaints.length}');

        notifyListeners(); // Notify listeners for any UI updates
        return _complaints;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Access token might be expired or invalid, try to regenerate it
        print('Access token expired or invalid, regenerating...');
        String? errorMessage = await regenerateAccessToken();

        if (errorMessage == null) {
          // If token was successfully regenerated, retry fetching complaints
          return await fetchComplaints();
        } else {
          // Handle error when regenerating the access token
          print('Failed to regenerate access token: $errorMessage');
          return [];
        }
      } else {
        print('Failed to load complaints. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error occurred while fetching complaints: $error');
      return [];
    }
  }

  // Method to update the status locally and notify listeners
  void updateStatusLocally(int index, String newStatus) {
    _complaints[index].status = newStatus; // Update the status locally
    notifyListeners(); // Notify the UI to rebuild with the new status
  }

  // Method to update the status in the backend (database)
  Future<void> updateComplaintStatusInDatabase(
      String complaintId, String newStatus) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      print(newStatus);
      print(accessToken);

      final url = Uri.parse('http://192.168.1.211:3000/issue/changeStatus');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          'issueId': complaintId,
          'newStatus': newStatus, // Send the new status to the backend
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Status cahnged -----------------');
        print('Status updated successfully in the backend.');
      } else {
        print(
            'Status faiiiiiiiiiiiiiiiiiiiiilllllllllllllllll -----------------');
        print('Failed to update status. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating status in the backend: $error');
    }
  }
}
