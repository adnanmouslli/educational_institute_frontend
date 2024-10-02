import 'dart:convert';

import 'package:education_managment/models/marks.dart';
import 'package:education_managment/models/student_model.dart';
import 'package:education_managment/utils/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/alerts.dart';

class HomeController extends GetxController {
  late StudentModel studentModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    studentModel = StudentModel.getStuderData();
    getAllMarks();
    getStudentStatus();
    print("student = ${studentModel.toMap()}");
  }

  // متغيرات لتخزين حالة التحميل والدفعات المالية
  var isLoading = false.obs;
  var disclosureList = [].obs;
  var studentStatus = [].obs;

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

          print("studentStatus : ${studentStatus}");
        }
      }
    }catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب البيانات');
      } finally {
      isLoading(false); // إنهاء التحميل
    }
  }



  // جلب الدفعات المالية من الـ API
  void getAllDiscloture() async {
    try {
      isLoading(true); // بدء التحميل
      // الاتصال بـ API للحصول على الدفعات
      var url = Uri.parse(getDisclosure);
      var response = await http.post(
          url ,
          body:  jsonEncode({'id_student': studentModel.id})
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          disclosureList.value = data['data']; // تخزين الدفعات المالية

          print("disclosureList : ${disclosureList}");

        } else {
          Get.snackbar('خطأ', 'فشل في جلب الدفعات المالية');
        }
      } else {
        Get.snackbar('خطأ', 'فشل في الاتصال بالخادم');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء جلب البيانات');
    } finally {
      isLoading(false); // إنهاء التحميل
    }
  }

  // إضافة دفعة جديدة
  void addNewPayment(String amount) async {
    try {
      isLoading(true); // بدء التحميل

      // إعداد بيانات الدفع الجديدة
      var url = Uri.parse(addDisclosure);
      var response = await http.post(
        url,
        body: jsonEncode({
          'id_student': studentModel.id, // استبدالها بالرقم الخاص بالطالب
          'id_supervisor': '1', // استبدالها بالرقم الخاص بالمشرف
          'paid_quantity': amount,
          'date': DateTime.now().toString(), // تاريخ الدفعة
        },)
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          Get.snackbar('نجاح', 'تم إضافة الدفعة بنجاح');
          getAllDiscloture(); // تحديث قائمة الدفعات بعد الإضافة
        } else {
          Get.snackbar('خطأ', 'فشل في إضافة الدفعة');
        }
      } else {
        Get.snackbar('خطأ', 'فشل في الاتصال بالخادم');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء إضافة الدفعة');
    } finally {
      isLoading(false); // إنهاء التحميل
    }
  }

  var pdfList = [].obs;

  // الدالة التي تجلب ملفات PDF بناءً على اسم الصف
  Future<void> getAllPdfs() async {
    try {
      isLoading.value = true;
      final url = Uri.parse(getFilePdf);

      // إرسال الطلب باستخدام GET
      final response = await http.post(
        url,
        headers: headerApi,
        body: jsonEncode({'class': studentModel.classLevel}), // إرسال اسم الصف كـ JSON
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // التأكد من نجاح الطلب
        if (data['status'] == 'success') {
          pdfList.value = data['data'];
        } else {
          pdfList.clear(); // في حالة عدم وجود بيانات
        }
      } else {
        throw Exception('فشل في تحميل البيانات');
      }

      print("pdfList: ${pdfList}");
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<MarksModel> marks = [];

  Future<void> getAllMarks() async {
    marks = [];
    try {
      http.Response res = await http.post(Uri.parse(getMarksUrl),
          body: jsonEncode({"id_student": studentModel.id}),
          headers: headerApi);
      print(res.body);
      if (jsonDecode(res.body)['status'] == "success") {
        List data = jsonDecode(res.body)['data'];
        for (var element in data) {
          marks.add(MarksModel.fromMap(element));
        }
      }

      print(marks.length);
      update();
    } catch (e) {
      print(e);
    }
  }
  List<AlertModel> alerts = [];

  Future<void> getAllAlerts() async {
    alerts = [];
    try {
      http.Response res = await http.post(Uri.parse(getAlertsUrl),
          body: jsonEncode({"id_student": studentModel.id}),
          headers: headerApi);
      print(res.body);
      if (jsonDecode(res.body)['status'] == "success") {
        List data = jsonDecode(res.body)['data'];
        for (var element in data) {
          alerts.add(AlertModel.fromMap(element));
        }
      }
      update();
    } catch (e) {
      print(e);
    }
  }
}