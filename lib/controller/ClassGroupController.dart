import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart';

class ClassGroupController extends GetxController {
  // المتغير الذي يحتوي على الصف المحدد
  var selectedGrade = ''.obs;

  // قائمة المواعيد الدراسية للشعبة
  var scheduleData = [].obs;

  // قائمة الشعب الدراسية
  RxList<dynamic> classGroups = [].obs;

  // الشعبة المختارة حاليا
  RxMap<String, dynamic> selectedClassGroup = RxMap<String, dynamic>();

  // اختيار شعبة معينة وحفظها في المتغير المحدد
  void selectClassGroup(Map<String, dynamic> classGroup) {
    selectedClassGroup.value = classGroup;
    scheduleData.value = [].obs;
  }

  // دالة لجلب مواعيد الشعبة المحددة بناءً على الـ groupId
  void fetchClassGroupSchedule(int groupId) async {

    print("id = ${groupId}");
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
          scheduleData.value = responseData['data'];
          print(responseData['data']);
        }
      } else {
        // في حال وجود خطأ في الاستجابة من الخادم
        print("Error: Server responded with status code ${response.statusCode}");
      }
    } catch (error) {
      // في حال وجود خطأ أثناء عملية الاتصال
      print("Error fetching classes: $error");
    }
  }

  // دالة لجلب الشعب الدراسية بناءً على الصف المحدد
  Future<void> fetchClasses(String grade) async {
    selectedGrade.value = grade; // تحديث الصف المختار

    try {
      final response = await http.post(
        Uri.parse(getClassesByGrade), // URL الخاص بجلب الشعب بناءً على الصف
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'class': selectedGrade.value}), // إرسال الصف إلى الـ API
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // إذا تم الجلب بنجاح، يتم تحديث قائمة الشعب
          classGroups.value = responseData['data'];
        } else {
          print("Error: Fetching classes failed with status ${responseData['status']}");
        }
      } else {
        print("Error: Server responded with status code ${response.statusCode}");
      }
    } catch (error) {
      // في حال وجود خطأ أثناء عملية الاتصال
      print("Error fetching classes: $error");
    }
  }
}
