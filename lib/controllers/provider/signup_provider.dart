import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:haca_review_main/models/base_url.dart';
import 'package:haca_review_main/models/siginup_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class AuthProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPassController = TextEditingController();

  // Base URL for the API
  final String _signupUrl = '$baseUrlll/signup';
  final String _loginUrl = '$baseUrlll/login';

  bool isLoading = false;

    bool _obscureText = true;

  bool get obscureText => _obscureText; // Getter for obscureText

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  // Method to sign up a user
  Future<String?> signup(UserModel user) async {
    isLoading = true;
    notifyListeners(); // Notify listeners to update the UI
    final url = Uri.parse(_signupUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');

        String? accessToken = responseData['accessToken'];
        String? refreshToken = responseData['refreshToken'];
        String? role = responseData['role'];

        // Null safety checks for essential fields
        if (accessToken == null || refreshToken == null || role == null) {
          return 'Failed to retrieve required data from server';
        }

        // Store tokens and role using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('role', role); // Store the role

        return null; // Return null to indicate success
      } else {
        // Log and return error
        print('Error: ${response.statusCode}, Response: ${response.body}');
        return 'Failed to sign up: ${response.body}';
      }
    } catch (error) {
      // Catch and log any unexpected errors
      print('Exception occurred: $error');
      return 'Error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners(); // Reset loading state after the request
    }
  }

  // Method to login a user
  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners(); // Notify listeners to update the UI
    final url = Uri.parse(_loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        final responseData = jsonDecode(response.body);

        // Extract tokens from response
        String accessToken = responseData['accessToken'];
        String refreshToken = responseData['refreshToken'];
        String role = responseData['role']; // Get role from login response

        // Store tokens and role using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('role', role); // Store the role

        return null; // Return null to indicate success
      } else {
        // Return the error message
        return 'Failed to login: ${response.body}';
      }
    } catch (error) {
      // Return a catch-all error message
      return 'Error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners(); // Reset loading state after the request
    }
  }

  // Method to retrieve the access token from SharedPreferences
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Method to retrieve the refresh token from SharedPreferences
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  // Method to retrieve the user role from SharedPreferences
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Method to clear the tokens and role (e.g., for logout)
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('role'); // Clear the role
  }

  // Method to check if the user is signed up or logged in based on access token
  Future<bool> isUserSignedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  // Method to check if the user is an admin
  Future<bool> isAdmin() async {
    final role = await getUserRole();
    return role == 'admin';
  }

  // Method to check if the user is a student
  Future<bool> isStudent() async {
    final role = await getUserRole();
    return role == 'student';
  }
}
