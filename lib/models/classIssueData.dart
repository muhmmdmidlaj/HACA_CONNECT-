import 'package:flutter/material.dart';

class IssueData with ChangeNotifier {
  String _title = '';
  String _description = '';
  String _category = '';
  String _urgency = '';

  String get title => _title;
  String get description => _description;
  String get category => _category;
  String get urgency => _urgency;

  void setIssueData(String title, String description, String category, String urgency) {
    _title = title;
    _description = description;
    _category = category;
    _urgency = urgency;
    notifyListeners();
  }
}
