import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart'; // قم باستبدال مسار ملف API_URLS حسب مشروعك

class TeacherController extends GetxController {
  var selectedGrade = ''.obs;
  var teacherName = ''.obs;
  var teacherSpecialty = ''.obs;
  var teacherAddress = ''.obs;
  var teacherPhoneNumber = ''.obs;
  var selectedSubjects = [].obs; // قائمة المواد المختارة

  var allSubjectNinth = [].obs; // مواد الصف التاسع
  var allSubjectBaccalaureate = [].obs; // مواد البكالوريا

  @override
  void onInit() {
    super.onInit();
    // تحميل المواد الخاصة بكل صف عند تهيئة الـ Controller
    getAllSubjects();
  }

  // جلب المواد حسب الصف
  Future<void> getAllSubjects() async {
    await getAllSubjectSelectNinth();
    await getAllSubjectSelectBaccalaureate();
  }

  // جلب مواد الصف التاسع
  Future<void> getAllSubjectSelectNinth() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectT), // رابط جلب مواد التاسع
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectNinth.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  // جلب مواد البكالوريا
  Future<void> getAllSubjectSelectBaccalaureate() async {
    try {
      final response = await http.post(
        Uri.parse(getAllSubjectB), // رابط جلب مواد البكالوريا
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          allSubjectBaccalaureate.value = responseData['data'];
        }
      }
    } catch (error) {
      print("error: $error");
    }
  }

  // اختيار/إلغاء اختيار مادة
  void toggleSubjectSelection(subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
  }

  // الحصول على معرفات المواد المختارة كقائمة مفصولة بفواصل
  String getSelectedSubjectIds() {
    return selectedSubjects.map((subject) => subject['id'].toString()).join(',');
  }

  // إعادة تعيين الحقول بعد الإرسال
  void resetFields() {
    selectedGrade.value = '';
    teacherName.value = '';
    teacherSpecialty.value = '';
    teacherAddress.value = '';
    teacherPhoneNumber.value = '';
    selectedSubjects.clear();
  }

  // إرسال بيانات المدرس إلى السيرفر
  Future<void> submitTeacher() async {
    String idSubjects = getSelectedSubjectIds();
    try {
      final response = await http.post(
        Uri.parse(addTeacherAPI), // رابط API لإضافة المدرس
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': teacherName.value,
          'specialization': teacherSpecialty.value,
          'address': teacherAddress.value,
          'phone': teacherPhoneNumber.value,
          'class': selectedGrade.value,
          'subjects': idSubjects,
        }),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة المدرس بنجاح');
          resetFields(); // تصفير الحقول بعد الإرسال
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
