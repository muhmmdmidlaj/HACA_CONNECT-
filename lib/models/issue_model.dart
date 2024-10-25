class IssueModel {
  final String title;
  final String category;
  final String school;
  final String batch;
  final String modeofClass;
  final String description;

  IssueModel({ 
    required this.title, 
    required this.category, 
    required this.school,
    required this.batch,
    required this.modeofClass,
    required this.description
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      title: json['title'],
      category: json['category'],
      school: json['school'],
      batch: json['batch'],
      modeofClass: json['modeofClass'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'school': school,
      'batch': batch,
      'modeofClass': modeofClass,
      'description': description,
    };
  }
}
