class ComplaintsResponse {
  final List<Complaint> complaints;

  ComplaintsResponse({required this.complaints});

  factory ComplaintsResponse.fromJson(Map<String, dynamic> json) {
    return ComplaintsResponse(
      complaints: (json['complaints'] as List)
          .map((complaint) => Complaint.fromJson(complaint))
          .toList(),
    );
  }
}

class Complaint {
  final int indexno;
  final String title;
  final String category;
  final String school;
  final String batch;
  final String modeofClass;
  final String description;
   String status;
  final int studentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Complaint({
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

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
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
}

class User {
  final String name;
  final String email;

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
}
