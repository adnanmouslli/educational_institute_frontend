import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // استخدام image_picker
import 'package:http/http.dart' as http;
import '../utils/api_urls.dart';

class AddPdfController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var className = ''.obs;
  var selectedFile = Rx<File?>(null);  // تحويل selectedFile إلى Rx
  final ImagePicker _picker = ImagePicker(); // إنشاء كائن ImagePicker

  Future<void> pickFile() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);  // تحديث قيمة selectedFile
    } else {
      print("No file selected");
    }
  }

  Future<void> uploadPdf() async {
    if (selectedFile.value == null) {
      Get.snackbar("Error", "Please select a file");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(addPdf),
    );

    request.fields['title'] = title.value;
    request.fields['id_supervisor'] = '1';  // قم بتعديل ID المشرف حسب الحاجة
    request.fields['description'] = description.value;
    request.fields['class'] = className.value;

    request.files.add(
      await http.MultipartFile.fromPath('filePdf', selectedFile.value!.path),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      Get.snackbar("Success", "File uploaded successfully");
    } else {
      Get.snackbar("Error", "Failed to upload file");
    }
  }
}
