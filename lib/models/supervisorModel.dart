import 'dart:convert';

import '../utils/cache_helper.dart';

class SuperviosrModel {
  int? id;
  String? username;
  String? password;
  String? email;
  int? isAdmin;

  SuperviosrModel(
      {this.id, this.username, this.password, this.email, this.isAdmin});

  factory SuperviosrModel.fromMap(Map<String, dynamic> json) {
    return SuperviosrModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      isAdmin: json['is_admin'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id":this.id,
      "username": this.username,
      "password": this.password,
      "email": this.email,
      "isAdmin": this.isAdmin,

    };
  }
  String toJson() => json.encode(toMap());

  factory SuperviosrModel.fromJson(String source) =>
      SuperviosrModel.fromMap(json.decode(source));

  static SuperviosrModel getSupervisorData() {
    return SuperviosrModel.fromJson(CacheHelper.getData(key: "supervisor"));
  }

}
