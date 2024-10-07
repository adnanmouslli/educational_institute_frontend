import 'dart:convert';
import 'dart:io';
import 'package:education_managment/utils/api_urls.dart';
import 'package:education_managment/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../utils/cache_helper.dart';

class AuthController extends GetxController {

  List<Map<String, String>> sections = [];
  String? selectedSection;
  String? classLevel;

  Future<void> fetchSectionsForClassLevel() async {
    if (classLevel == null || classLevel!.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(getClassesByGrade),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'class': classLevel}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // تأكد من أن البيانات التي تم استرجاعها هي قائمة
          sections = List<Map<String, String>>.from(
              responseData['data'].map((section) => {
                'id': section['id'].toString(),  // تأكد من تحويل id إلى String
                'name': section['name'].toString()  // تأكد من تحويل name إلى String
              }).toList()
          );

          selectedSection = null; // إعادة تعيين الشعب المختارة
          update(); // تحديث واجهة المستخدم
        } else {
          Get.snackbar("خطأ", "فشل في جلب البيانات",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (error) {
      print("Error fetching classes: $error");
      Get.snackbar("خطأ", "حدث خطأ أثناء جلب الشعب",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  File? idImageFile;
  final ImagePicker _picker = ImagePicker();


  Future<void> pickIdImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      idImageFile = File(image.path);
      update(); // لتحديث واجهة المستخدم بعد اختيار الصورة
    } else {
      Get.snackbar("خطأ", "لم يتم اختيار أي صورة",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // بقية الحقول
  late TextEditingController fullName;
  late TextEditingController school;
  late TextEditingController phone;
  late TextEditingController username;
  late TextEditingController password;
  String? gender;
  String? idSection;


  @override
  void onInit() {
    super.onInit();
    fullName = TextEditingController();
    school = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
  }

  Future<void> register() async {
    try {
      // تحقق من أن صورة البطاقة تم تحديدها
      if (idImageFile == null) {
        Get.snackbar("خطأ", "يجب تحميل صورة البطاقة");
        return;
      }

      // إنشاء طلب Multipart
      var request = http.MultipartRequest('POST', Uri.parse(registerUrl));


      // إضافة الحقول النصية إلى الطلب
      request.fields['full_name'] = fullName.text;
      request.fields['username'] = username.text;
      request.fields['password'] = password.text;
      request.fields['school'] = school.text;
      request.fields['phone'] = phone.text;
      request.fields['gender'] = gender ?? '';
      request.fields['class'] = classLevel ?? '';
      request.fields['id_section'] = idSection ?? '';

      // إضافة صورة البطاقة كـ multipart file
      var imageStream = http.ByteStream(idImageFile!.openRead());
      var imageLength = await idImageFile!.length();
      var imageName = basename(idImageFile!.path);
      request.files.add(http.MultipartFile(
        'image', // هذا المفتاح يجب أن يتوافق مع ما يتوقعه الـ API
        imageStream,
        imageLength,
        filename: imageName,
      ));

      // إرسال الطلب
      var response = await request.send();
      print(response);

      // قراءة الرد
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData.body);
        if (jsonResponse['status'] == 'success') {
          Get.snackbar("", "تم إرسال طلبك بنجاح");
           fullName.clear();
          school.clear();
           phone.clear();
           username.clear();
           password.clear();

          update();

        } else {
          Get.snackbar("خطأ", jsonResponse['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("خطأ", "حدث خطأ أثناء محاولة التسجيل",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
      Get.snackbar("خطأ", "حدث خطأ أثناء محاولة التسجيل",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> login(String username, String password) async {
    print("test");
    try {
      var req = await http.post(Uri.parse(loginUrl),
          body: jsonEncode({"username": username, "password": password}),
          headers: headerApi);
      if (req.statusCode == 200) {
        if (jsonDecode(req.body)['status'] == "success") {
          CacheHelper.putData(
              key: "student",
              value: jsonEncode(jsonDecode(req.body)['student']));
          Get.offNamed(RoutesPath.home);
        } else {
          Get.snackbar("خطأ", "خطأ في اسم المستخدم او كلمة المرور",
              colorText: Colors.white, backgroundColor: Colors.red);
        }
      }
      else {

      }
      print("okk");
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginSupervisor(String username, String password) async {
    try {
      var req = await http.post(Uri.parse(loginSupervisorUrl),
          body: jsonEncode({"username": username, "password": password}),
          headers: headerApi);
      if (req.statusCode == 200) {
        if (jsonDecode(req.body)['status'] == "success") {
          CacheHelper.putData(
              key: "supervisor",
                    value: jsonEncode(jsonDecode(req.body)['supervisor']));
          Get.offNamed(RoutesPath.homeSupervisor);
        } else {
          Get.snackbar("خطأ", "خطأ في اسم المستخدم او كلمة المرور",
              colorText: Colors.white, backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> fetchClasses() async {
  //   if (selectedGrade.value.isEmpty) return;
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(getClassesByGrade),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'class': selectedGrade.value}),
  //     );
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       if (responseData['status'] == 'success') {
  //         classes.value = responseData['data'];
  //       }
  //     }
  //   } catch (error) {
  //     print("Error fetching classes: $error");
  //   }
  // }
}