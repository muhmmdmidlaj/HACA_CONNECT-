import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> regenerateAccessToken() async {
  final url = Uri.parse('http://192.168.1.211:3000/refresh-token');

  try {
    // Retrieve the refresh token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null) {
      return "Refresh token not found. Please log in again.";
    }

    // Prepare the JSON body for the API request
    final refreshRequest = {
      'refreshToken': refreshToken,
    };

    // Make the POST request to refresh the access token
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(refreshRequest),
    );

    if (response.statusCode == 200) {
      // Successful refresh, parse the response
      final responseData = json.decode(response.body);

      // Extract the new access token from the response
      String newAccessToken = responseData['accessToken'];

      // Store the new access token in SharedPreferences
      await prefs.setString('accessToken', newAccessToken);

      // Return null to indicate success
      return null;
    } else {
      // If refresh failed, return the error message
      return "Failed to refresh token with status code: ${response.statusCode}";
    }
  } catch (error) {
    // Handle network or other errors
    return "Error occurred: $error";
  }
}
