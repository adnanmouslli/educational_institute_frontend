import 'dart:convert';

import 'package:education_managment/models/marks.dart';
import 'package:education_managment/models/student_model.dart';
import 'package:education_managment/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/alerts.dart';

class HomeController extends GetxController {
  late StudentModel studentModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    studentModel = StudentModel.getStuderData();
    getAllMarks();
    print("student = ${studentModel.toMap()}");
  }

  List<MarksModel> marks = [];

  Future<void> getAllMarks() async {
    marks = [];
    try {
      http.Response res = await http.post(Uri.parse(getMarksUrl),
          body: jsonEncode({"id_student": studentModel.id}),
          headers: headerApi);
      print(res.body);
      if (jsonDecode(res.body)['status'] == "success") {
        List data = jsonDecode(res.body)['data'];
        for (var element in data) {
          marks.add(MarksModel.fromMap(element));
        }
      } else {
        Get.snackbar("خطا", "حدث خطأ اثناء جلب العلامات اعد المحاولة ");
      }
      print(marks.length);
      update();
    } catch (e) {
      print(e);
    }
  }
  List<AlertModel> alerts = [];

  Future<void> getAllAlerts() async {
    alerts = [];
    try {
      http.Response res = await http.post(Uri.parse(getAlertsUrl),
          body: jsonEncode({"id_student": studentModel.id}),
          headers: headerApi);
      print(res.body);
      if (jsonDecode(res.body)['status'] == "success") {
        List data = jsonDecode(res.body)['data'];
        for (var element in data) {
          alerts.add(AlertModel.fromMap(element));
        }
      } else {
        Get.snackbar("خطا", "حدث خطأ اثناء جلب العلامات اعد المحاولة ");
      }
      update();
    } catch (e) {
      print(e);
    }
  }
}