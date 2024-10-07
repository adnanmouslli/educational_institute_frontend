import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart';

class ClassTeacherController extends GetxController {
  var selectedGrade = ''.obs;
  var selectedClass = ''.obs;
  var selectedSubject = ''.obs;
  var selectedTeacher = ''.obs;
  var selectedSubjectTeacherId = ''.obs;


  var classes = [].obs;
  var subjects = [].obs;
  var teachers = [].obs;
  var teacherSubjects = [].obs;


  // Fetch classes based on grade
  Future<void> fetchClasses() async {
    if (selectedGrade.value.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(getClassesByGrade),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'class': selectedGrade.value}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          classes.value = responseData['data'];
        }
      }
    } catch (error) {
      print("Error fetching classes: $error");
    }
  }

  // Fetch subjects based on grade
  Future<void> fetchSubjects() async {
    if (selectedGrade.value.isEmpty) return;

    String selectClass = '' ;
    if(selectedGrade == 'تاسع') selectClass = 'T' ;
    else selectClass = 'B' ;
    try {
      final response = await http.post(
        Uri.parse(getSubjectsByGrade),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'class': selectClass}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          subjects.value = responseData['data'];
        }
      }
    } catch (error) {
      print("Error fetching subjects: $error");
    }
  }

  // Fetch teachers based on subject
  Future<void> fetchTeachers() async {
    if (selectedSubject.value.isEmpty) return;

    print(selectedSubject.value);
    try {
      final response = await http.post(
        Uri.parse(getTeachersBySubject),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_sub': selectedSubject.value}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {

          teachers.value = responseData['data'];
          print("teachers.value = ${teachers.value}");
        }
      }
    } catch (error) {
      print("Error fetching teachers: $error");
    }
  }

  Future<void> fetchTeacherSubjects() async {
    if (selectedTeacher.value.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(getTeacherSubjects),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_teacher': selectedTeacher.value}),
      );
      print("fetchTeacherSubjects = ${response.body}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          teacherSubjects.value = responseData['data'];
        }
      }
    } catch (error) {
      print("Error fetching teacher subjects: $error");
    }
  }

  Future<void> submitSchedule() async {
    try {


      for (var element in teacherSubjects) {
        if (element['id_subject'].toString() == selectedSubject.value &&
            element['id_teacher'].toString() == selectedTeacher.value) {
          selectedSubjectTeacherId.value = element['id'].toString();
          break;  // التوقف عند إيجاد أول تطابق
        }
      }
      
      print("selectedSubjectTeacherId.value = ${selectedSubjectTeacherId.value}");
      print("selectedClass.value = ${selectedClass.value}");

      final response = await http.post(
        Uri.parse(addTeachingSection),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id_subject_teacher" : selectedSubjectTeacherId.value ,
          "id_section" : selectedClass.value
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة وقت التدريس بنجاح');
          clearSelections(); // Reset selections
        } else {
          Get.snackbar('فشل', responseData['message']);
        }
      } else {
        Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
      }
    } catch (error) {
      print("Error submitting schedule: $error");
    }
  }

  @override
  void onInit() {
    super.onInit();
    clearSelections() ;
    print("init teacher class");
    update();
  }

  void clearSelections() {
    selectedTeacher.value = '' ;
    selectedSubject.value = '' ;
    selectedClass.value = '' ;
    selectedGrade.value = '' ;
    selectedSubjectTeacherId.value = '' ;
  }


}
