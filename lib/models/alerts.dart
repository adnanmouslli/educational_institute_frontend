import 'dart:convert';

class AlertModel {
  final String title;
  final String body;
  final String supervisorName;
  final String? date;
  AlertModel({
    required this.title,
    required this.body,
    required this.supervisorName,
    this.date
  });

  factory AlertModel.fromMap(Map<String, dynamic> json) {
    return AlertModel(
      title: json['title'],
      body: json['body'],
      supervisorName: json['name'], // This assumes 'name' is the supervisor's name
      date: json['date'], // This assumes 'name' is the supervisor's name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'name': supervisorName,
    };
  }

  String toJson() => json.encode(toMap());

  factory AlertModel.fromJson(String source) =>
      AlertModel.fromMap(json.decode(source));
}

