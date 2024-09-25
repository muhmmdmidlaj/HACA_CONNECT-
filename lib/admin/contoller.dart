import 'package:flutter/material.dart';

class StatusProvider with ChangeNotifier {
  final List<String> statuses = ['Resolved', 'Ongoing', 'Pending'];
  final List<String> _selectedStatuses = List<String>.filled(50, 'Resolved');

  List<String> get selectedStatuses => _selectedStatuses;

  void updateStatus(int index, String newValue) {
    _selectedStatuses[index] = newValue;
    notifyListeners();
  }
}
