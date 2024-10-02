
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/supervisorModel.dart';
import '../utils/api_urls.dart';
import 'package:http/http.dart' as http;

class addMarkController extends GetxController {

  late SuperviosrModel superviosrModel;
  late TextEditingController markController ;

  List allStudentT = [] ;
  List allStudentB = [] ;
  List allSubjectT = [] ;
  List allSubjectB = [] ;

  var selectedStudent = ''.obs;
  var selectedSubject = ''.obs;
  var selectedMarkType = ''.obs;

  Future<void> getAllStudentSelectT() async {
    try {
      final response = await http.post(
        Uri.parse(getAllStudentT),
        headers: {'Content-Type': 'application/json'},

      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allStudentT.addAll(responseData['data']);
          update();
          print(responseData['data']);
        }
      }
    } catch (error) {
      print("error: $error");

    }
  }
  Future<void> getAllStudentSelectB() async {
    try {
      final response = await http.post(
        Uri.parse(getAllStudentB),
        headers: {'Content-Type': 'application/json'},

      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allStudentB.addAll(responseData['data']);
          update();
          print(responseData['status']);
        }
      }
    } catch (error) {
      print("error: $error");

    }
  }
  Future<void> getAllSubjectSelectT() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectT),
        headers: {'Content-Type': 'application/json'},

      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectT.addAll(responseData['data']);
          update();
          print(responseData['status']);
        }
      }
    } catch (error) {
      print("error: $error");

    }
  }
  Future<void> getAllSubjectSelectB() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectB),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectB.addAll(responseData['data']);
          update();
          print(responseData['status']);
        }
      }
    } catch (error) {
      print("error: $error");

    }
  }

  Future<void> addMark() async {
    try {
      final response = await http.post(
        Uri.parse(addMarkStudent),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_student': selectedStudent.value,
          'mark': markController.text,
          'id_supervisor': superviosrModel.id,
          'id_subject': selectedSubject.value,
          'type' : selectedMarkType.value
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة العلامة بنجاح');
          // مسح الحقول بعد الإرسال
          markController.clear();
          update();
          print(responseData['status']);
        } else {
          Get.snackbar('فشل', responseData['message']);
        }
      } else {
        Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
      }
    } catch (error) {
      print("error: $error");
      Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال البيانات');
    }


  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    superviosrModel = SuperviosrModel.getSupervisorData();
    markController = TextEditingController();
    getAllStudentSelectT();
    getAllStudentSelectB();
    getAllSubjectSelectT();
    getAllSubjectSelectB();


  }

}
