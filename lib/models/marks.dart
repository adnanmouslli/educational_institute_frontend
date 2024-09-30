import 'dart:convert';

import 'package:education_managment/utils/extenstions.dart';

class MarksModel {
  final String mark;
  final String subject_name;
  final String supervisor_name;
  final String? grade;
  final String? date;

  MarksModel({
    required this.mark,
    required this.subject_name,
    required this.supervisor_name,
    this.grade,
    this.date
  });

  factory MarksModel.fromMap(Map<String, dynamic> json) {
    return MarksModel(
      mark: json['mark'],
      subject_name: json['subject_name'],
      supervisor_name: json['supervisor_name'],
      date: json['date'],
      grade: double.parse(json['mark']).getGrade(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "full_name": this.mark,
      "subject_name": this.subject_name,
      "supervisor_name": this.supervisor_name,
    };
  }

  String toJson() => json.encode(toMap());

  factory MarksModel.fromJson(String source) =>
      MarksModel.fromMap(json.decode(source));

}
