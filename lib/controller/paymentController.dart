import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/supervisorModel.dart';
import '../utils/api_urls.dart';

class PaymentController extends GetxController {
  var students = [].obs;
  var selectedStudent = ''.obs;

  late SuperviosrModel superviosrModel;
  late TextEditingController paymentController;

  @override
  void onInit() {
    super.onInit();
    paymentController = TextEditingController();
    superviosrModel = SuperviosrModel.getSupervisorData();
  }

  Future<void> getAllStudents(String classType) async {
    try {
      final response = await http.post(
        Uri.parse(getAllStudentByClass),
        body: jsonEncode({
          'class' : classType
        }),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          students.value = responseData['data'];
          print("students = ${students}");
        }
      } else {
        Get.snackbar('خطأ', 'فشل في جلب بيانات الطلاب');
      }
    } catch (error) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب بيانات الطلاب');
    }
  }

  Future<void> addPayment() async {
    try {
      final response = await http.post(
        Uri.parse(addPayments),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id_student":  selectedStudent.value,
          "id_supervisor" :  superviosrModel.id,
          "paid_quantity" :  paymentController.text,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة الدفعة المالية بنجاح');
          paymentController.clear();
        } else {
          Get.snackbar('فشل', responseData['message']);
        }
      } else {
        Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
      }
    } catch (error) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال البيانات');
    }
  }
}
