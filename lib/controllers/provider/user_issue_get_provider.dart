import 'package:flutter/material.dart';
import 'package:haca_review_main/controllers/get_access_tocken.dart';
import 'package:haca_review_main/models/base_url.dart';
import 'package:haca_review_main/models/user_issue_get_model.dart';
import 'dart:convert';
import 'dart:io'; // For handling SocketException (network error)
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserIssueGetProvider extends ChangeNotifier {
  Future<List<UserIssue>> fetchUserIssues() async {
    final url = Uri.parse('$baseUrlll/issue/userIssues');

    try {
      // Retrieve the access token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        // Handle case where access token is not available
        throw Exception('Access token not found. Please log in again.');
      }

      // Attempt to make the API call with the access token in the Authorization header
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $accessToken', // Add access token to the headers
        },
      );

      if (response.statusCode == 200) {
        // Try to parse the JSON response
        try {
          List<dynamic> jsonResponse = json.decode(response.body)['issues'];
          return jsonResponse
              .map((issue) => UserIssue.fromJson(issue))
              .toList();
        } catch (e) {
          // Handle JSON parsing error
          throw Exception('Failed to parse JSON data: $e');
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Handle case where access token is expired, and regenerate it
        print('Access token expired. Attempting to regenerate...');
        String? refreshError = await regenerateAccessToken();

        if (refreshError == null) {
          // If token is successfully regenerated, retry fetching the user issues
          return await fetchUserIssues();
        } else {
          // Handle refresh token failure
          throw Exception('Failed to refresh access token: $refreshError');
        }
      } else {
        // Handle non-200 HTTP responses
        throw Exception(
            'Failed to load issues: Server returned status code ${response.statusCode}');
      }
    } on SocketException {
      // Handle network errors (e.g., no internet connection)
      throw Exception('Failed to load issues: No internet connection');
    } on FormatException {
      // Handle JSON formatting issues (in case response is not JSON)
      throw Exception('Failed to load issues: Invalid JSON format');
    } catch (e) {
      // Handle any other type of error
      throw Exception('Failed to load issues: $e');
    }
  }
}
