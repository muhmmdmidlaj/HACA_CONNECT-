import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearTokens() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  await prefs.remove('refreshToken');
  await prefs.remove('role'); // Clear the role
  await prefs.setBool('isLoggedIn', false);
}
