import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart';

class TeacherScheduleController extends GetxController {
  var selectedTeacher = ''.obs;
  var selectedSubject = ''.obs;
  var selectedSubjectTeacherId = ''.obs;

  var selectedDay = ''.obs;
  var selectedTime = ''.obs;

  var allTeachers = [].obs;
  var teacherSubjects = [].obs;
  var daysOfWeek = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'].obs;
  var availableTimes = ['8:00 AM', '10:00 AM', '12:00 PM', '2:00 PM', '4:00 PM', '6:00 PM'].obs;

  
  // Fetch the list of teachers
  Future<void> fetchAllTeachers() async {
    print("hello");
    try {
      final response = await http.get(Uri.parse(getAllTeachers));
      print("fetchAllTeachers = ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allTeachers.value = responseData['data'];
        }
      }
    } catch (error) {
      print("Error fetching teachers: $error");
    }
  }

  // Fetch subjects for the selected teacher
  Future<void> fetchTeacherSubjects() async {
    if (selectedTeacher.value.isEmpty) return;

    selectedSubject.value = '' ;
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

  // Submit the teaching schedule
  Future<void> submitSchedule() async {
    try {


      for (var element in teacherSubjects) {
        if (element['id_subject'].toString() == selectedSubject.value &&
            element['id_teacher'].toString() == selectedTeacher.value) {
          selectedSubjectTeacherId.value = element['id'].toString();
          break;  // التوقف عند إيجاد أول تطابق
        }
      }

      final response = await http.post(
        Uri.parse(addTeachingSchedule),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id_subject_teacher" : selectedSubjectTeacherId.value ,
          'day': selectedDay.value,
          'hour': selectedTime.value,
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

  // Reset all selections
  void clearSelections() {
    selectedTeacher.value = '';
    selectedSubject.value = '';
    selectedDay.value = '';
    selectedTime.value = '';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllTeachers();
    update() ;
  }
}
