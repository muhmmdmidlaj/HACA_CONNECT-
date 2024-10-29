class UserIssue {
  int indexno;
  String title;
  String category;
  String school;
  String batch;
  String modeofClass;
  String description;
  String status;
  int studentId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  UserIssue({
    required this.indexno,
    required this.title,
    required this.category,
    required this.school,
    required this.batch,
    required this.modeofClass,
    required this.description,
    required this.status,
    required this.studentId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory UserIssue.fromJson(Map<String, dynamic> json) {
    return UserIssue(
      indexno: json['indexno'],
      title: json['title'],
      category: json['category'],
      school: json['school'],
      batch: json['batch'],
      modeofClass: json['modeofClass'],
      description: json['description'],
      status: json['status'],
      studentId: json['studentId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indexno': indexno,
      'title': title,
      'category': category,
      'school': school,
      'batch': batch,
      'modeofClass': modeofClass,
      'description': description,
      'status': status,
      'studentId': studentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class User {
  String name;
  String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
