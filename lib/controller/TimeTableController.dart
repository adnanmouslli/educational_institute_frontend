import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/student_model.dart';
import '../utils/api_urls.dart';

class TimeTableController extends GetxController {

  var timeTableData = [];
  var mySubjects = [];

  late StudentModel studentModel;

  @override
  void onInit() {
    studentModel = StudentModel.getStuderData();

    // استدعاء الدالتين بشكل متزامن وانتظار اكتمال كلاهما قبل تنفيذ الفلترة
    fetchDataAndFilter();

    super.onInit();
  }

  Future<void> fetchDataAndFilter() async {
    // انتظار اكتمال كلا عمليات الجلب
    await Future.wait([
      fetchClassGroupSchedule(int.parse(studentModel.id_section)),
      fetchSubjectStudent(int.parse(studentModel.id!)),
    ]);

    // بعد اكتمال عمليات الجلب، نقوم بتطبيق الفلترة
    filterTimeTableData();
  }

  Future<void> fetchClassGroupSchedule(int groupId) async {
    try {
      final response = await http.post(
        Uri.parse(getSectionDetails), // URL الخاص بجلب تفاصيل الشعبة
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_section': groupId.toString()}), // إرسال الـ id_section إلى الـ API
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // إذا تم الجلب بنجاح، يتم تحديث البيانات
          timeTableData = responseData['data'];
          update();
        }
      } else {
        print("Error: Server responded with status code ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching classes: $error");
    }
  }

  Future<void> fetchSubjectStudent(int idStudent) async {
    try {
      final response = await http.post(
        Uri.parse(getSubjectStudent), // URL الخاص بجلب تفاصيل الشعبة
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_student': idStudent.toString()}), // إرسال الـ id_student إلى الـ API
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // إذا تم الجلب بنجاح، يتم تحديث البيانات
          mySubjects = responseData['data'];
          update();
        }
      } else {
        print("Error: Server responded with status code ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching subjects: $error");
    }
  }

  // فلترة المواد من timeTableData بناءً على mySubjects
  void filterTimeTableData() {
    // الحصول على قائمة أسماء المواد في mySubjects
    var subjectNames = mySubjects.map((subject) => subject['name']).toList();

    // حذف العناصر من timeTableData التي لا تكون المادة موجودة في subjectNames
    timeTableData.removeWhere((item) {
      return !subjectNames.contains(item['subjectName'].toString());
    });

    // تحديث البيانات بعد الفلترة
    update();
  }
}
