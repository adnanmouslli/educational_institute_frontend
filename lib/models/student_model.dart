import 'dart:convert';

import 'package:education_managment/utils/cache_helper.dart';

class StudentModel {
  final String? id;
  final String fullName;
  final String school;
  final String phone;
  final String gender;
  final String classLevel;
  final String image_url;
  final String username;
  final String? password;
  final String? studentNumber;
  final String id_section;




  StudentModel({
    required this.fullName,
    required this.school,
    required this.phone,
    required this.gender,
    required this.classLevel,
    required this.image_url,
    required this.username,
    this.password,
    this.studentNumber,
    this.id,
    required this.id_section
  });

  factory StudentModel.fromMap(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['full_name'],
      school: json['school'],
      phone: json['phone'],
      gender: json['gender'],
      classLevel: json['class'],
      image_url: json['image_url'],
      username: json['username'],
      studentNumber: json['studentNumber'],
      id: json['id'].toString(),
      id_section: json['id_section'].toString()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "full_name": this.fullName,
      "school": this.school,
      "phone": this.phone,
      'gender': this.gender,
      "class": this.classLevel == "تاسع" ? "T" : "B",
      "image_url": this.image_url,
      "username": this.username,
      "password": this.password,
      "studentNumber":studentNumber,
      "id_section":id_section
    };
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source));

  static StudentModel getStuderData() {
    return StudentModel.fromJson(CacheHelper.getData(key: "student"));
  }
}
