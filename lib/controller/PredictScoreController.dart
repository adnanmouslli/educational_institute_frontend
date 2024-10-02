import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/student_model.dart';
import '../utils/api_urls.dart';

class PredictScoreController extends GetxController {
  var quiz1 = 0.0.obs;
  var quiz2 = 0.0.obs;
  var midterm = 0.0.obs;
  var isLoading = false.obs; // Loading state

  var predictionAccuracy = 0.0.obs; // إضافة متغير دقة التنبؤ
  var predictedFinalScore = 0.0.obs;
  var performanceAnalysis = {}.obs;
  var studentStatus = [].obs;
  late StudentModel studentModel;


  void getStudentStatus() async {
    try {

      var url = Uri.parse(getStatus);
      var response = await http.post(
          url,
          body: jsonEncode({'id_student': studentModel.id})
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          studentStatus.value = data['data']; // تخزين الدفعات المالية

          print("studentStatus==== : ${studentStatus}");
          quiz1.value = studentStatus.firstWhere((element) => element['type'] == 'quiz1',)['avg_mark'];
          quiz2.value = studentStatus.firstWhere((element) => element['type'] == 'quiz2',)['avg_mark'];
          midterm.value = studentStatus.firstWhere((element) => element['type'] == 'midterm',)['avg_mark'];

          print("quiz1.value = ${quiz1.value}") ;
          print("quiz2.value = ${quiz2.value}") ;
          print("midterm.value = ${midterm.value}") ;


          update();
        }
      }
    }catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب البيانات');
    } finally {
      isLoading(false); // إنهاء التحميل
    }
  }


  Future<void> predictScore() async {
    isLoading.value = true; // Set loading to true
    update();

    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    final url = Uri.parse(serverAi);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'quiz1': quiz1.value,
          'quiz2': quiz2.value,
          'midterm': midterm.value,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        predictedFinalScore.value = result['predicted_final_score'];
        performanceAnalysis.value = result['performance_analysis'];
        predictionAccuracy.value = result['prediction_accuracy'];


      } else {
        Get.snackbar('Error', 'Failed to get prediction');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print('An error occurred: $e');
    }
    isLoading.value = false; // Set loading to false after completion
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    studentModel = StudentModel.getStuderData();
    getStudentStatus();


  }
}
