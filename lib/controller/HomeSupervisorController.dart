import 'dart:convert';
import 'package:education_managment/models/supervisorModel.dart';
import 'package:education_managment/utils/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SupervisorHomeController extends GetxController {
  late SuperviosrModel superviosrModel;

  // تغيير المتغيرات إلى TextEditingController
  late TextEditingController studentNumberController ;
  late TextEditingController titleController ;
  late TextEditingController bodyController;

  // دالة لإرسال البيانات إلى API
  Future<void> submitAlert() async {
    try {
      final response = await http.post(
        Uri.parse(addAlert),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentNumber': studentNumberController.text,
          'title': titleController.text,
          'body': bodyController.text,
          'id_supervisor': superviosrModel.id.toString() != '' ? superviosrModel.id.toString() : "1",
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة التنبيه بنجاح');
          // مسح الحقول بعد الإرسال
          studentNumberController.clear();
          titleController.clear();
          bodyController.clear();
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
    super.onInit();
    superviosrModel = SuperviosrModel.getSupervisorData();

     studentNumberController = TextEditingController();
     titleController = TextEditingController();
     bodyController = TextEditingController();

     print("student = ${superviosrModel.toMap()}");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    studentNumberController.dispose();
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }


}
