import 'package:flutter/material.dart';
import 'package:haca_review_main/models/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _obscureText = true;

  bool get obscureText => _obscureText; // Getter for obscureText

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  // Login method to store access token, refresh token, and role in SharedPreferences
  Future<String?> login() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrlll/login');
    final loginRequest = LoginRequest(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginRequest.toJson()),
      );

      if (response.statusCode == 200) {
        // Successful login
        final responseData = json.decode(response.body);

        // Extract tokens and role from the response
        String accessToken = responseData['accessToken'];
        String refreshToken = responseData['refreshToken'];
        String role = responseData['role']; // New role field

        // Store tokens and role using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('role', role); // Store role

        print("Login successful: $responseData");

        // Return null to indicate success
        return null;
      } else {
        // Parse error message if available
        final errorData = json.decode(response.body);
        String errorMessage =
            errorData['message'] ?? "Login failed. Please try again.";
        return errorMessage;
      }
    } catch (error) {
      return "Error occurred: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to get the role from SharedPreferences
  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Method to get access token from SharedPreferences
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Method to get refresh token from SharedPreferences
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  // Logout method to clear stored tokens and role
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('role'); // Clear role information
    notifyListeners();
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }
}
