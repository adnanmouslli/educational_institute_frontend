import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/api_urls.dart';

class SectionController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  var selectedClass = ''.obs;
  List<String> classOptions = ['بكلوريا', 'تاسع'];

  // دالة لاختيار التاريخ
  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      if (isStartDate) {
        startDateController.text = formattedDate;
      } else {
        endDateController.text = formattedDate;
      }
      update();
    }
  }

  // دالة لإرسال البيانات إلى API
  Future<void> submitSection() async {
    try {
      final response = await http.post(
        Uri.parse(addSection),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'class': selectedClass.value,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة الشعبة بنجاح');
          clearFields();
        } else {
          Get.snackbar('فشل', responseData['message']);
        }
      } else {
        Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
      }
    } catch (error) {
      print("error: ${error}");
      Get.snackbar('خطأ', 'حدث خطأ أثناء إرسال البيانات');
    }
  }

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedClass.value = classOptions.first;  // تعيين الصف الأول كقيمة افتراضية
    }

  // دالة لتنظيف الحقول بعد الإرسال
  void clearFields() {
    nameController.clear();
    selectedClass.value = '';
    startDateController.clear();
    endDateController.clear();
    selectedClass.value = classOptions.first;  // تعيين الصف الأول كقيمة افتراضية
    update();
  }
  @override
  void onClose() {
    nameController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }
}