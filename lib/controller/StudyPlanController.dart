import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart';


class StudyPlanController extends GetxController {
  var selectedGrade = ''.obs;
  var selectedStudent = ''.obs;
  var selectedSubjects = [].obs; // List of selected subjects

  var allStudentT = [].obs; // Ninth grade students
  var allStudentB = [].obs; // Baccalaureate students
  var allSubjectT = [].obs; // Ninth grade subjects
  var allSubjectB = [].obs; // Baccalaureate subjects

  // Fetch Ninth grade students
  Future<void> getAllStudentSelectT() async {
    try {
      final response = await http.post(
        Uri.parse(getAllStudentT),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allStudentT.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  // Fetch Baccalaureate students
  Future<void> getAllStudentSelectB() async {
    try {
      final response = await http.post(
        Uri.parse(getAllStudentB),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allStudentB.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  // Fetch Ninth grade subjects
  Future<void> getAllSubjectSelectT() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectT),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectT.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  // Fetch Baccalaureate subjects
  Future<void> getAllSubjectSelectB() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectB),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectB.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  void toggleSubjectSelection(subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
  }


  String getSelectedSubjectIds() {
    return selectedSubjects.map((subject) => subject['id'].toString()).join(',');
  }

  Future<void> submitStudyPlan()  async {
    String idSubjects = getSelectedSubjectIds();
    try {
      final response = await http.post(
        Uri.parse(addPackage),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_student': selectedStudent.value,
          'id_subjects': idSubjects,
          }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة المواد بنجاح');


          // تصفير الحقول بعد الإرسال
          selectedGrade.value = '';
          selectedStudent.value = '';
          selectedSubjects.clear();

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
    print("Selected subjects: $idSubjects");
  }
}
